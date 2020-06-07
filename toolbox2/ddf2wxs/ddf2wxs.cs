/**************************************************************************
 *
 *  Copyright 2020, Roger Brown
 *
 *  This file is part of Roger Brown's Toolkit.
 *
 *  This program is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU Lesser General Public License as published by the
 *  Free Software Foundation, either version 3 of the License, or (at your
 *  option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 *  more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

 /* 
  * $Id$
  */
 
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Xml;

namespace ddf2wxs
{
    class DirectoryEntry
    {
        public string Id, Name;
        public DirectoryEntry Parent;
        public List<DirectoryEntry> Children=new List<DirectoryEntry>();
    }

    class Program
    {
        static readonly string WixNamespace = "http://schemas.microsoft.com/wix/2006/wi";
        static readonly List<DirectoryEntry> directories = new List<DirectoryEntry>();
        static readonly XmlDocument doc = new XmlDocument();
        static XmlNamespaceManager nsmgr;

        static void Main(string[] args)
        
        {
            string 
                inFile=null, 
                outFile=null, 
                headerFile=null,
                packageName=null,
                ddfFile=null;

            {
                int i = 0;

                while (i < args.Length)
                {
                    string op = args[i++];

                    switch (op)
                    {
                        case "-i": inFile = args[i++]; break;
                        case "-o": outFile = args[i++]; break;
                        case "-h": headerFile = args[i++]; break;
                        case "-p": packageName = args[i++]; break;
                        case "-d": ddfFile = args[i++]; break;
                        default:
                            throw new Exception("unknown option " + op);
                    }
                }
            }

            using (FileStream str = new FileStream(inFile, FileMode.Open, FileAccess.Read))
            {
                doc.Load(str);
            }

            nsmgr = new XmlNamespaceManager(doc.NameTable);
            nsmgr.AddNamespace("wi", WixNamespace);

            {
                XmlNodeList directoryNodes = doc.SelectNodes("/wi:Wix/wi:Fragment/wi:Directory", nsmgr);

                int count = directoryNodes.Count;

                int i = 0;

                while (i < count)
                {
                    AddDirectory( null, directoryNodes[i++]);
                }
            }

            {
                int i = 0;
                while (i < directories.Count)
                {
                    DirectoryEntry de = directories[i++];

                    Debug.WriteLine("has " + de.Id + " as "+de.Name);
                }
            }

            DirectoryEntry currentDirectory=null;

            using (StreamReader reader = new StreamReader(ddfFile)) 
            {
                string line;

                while ((line = reader.ReadLine()) != null)
                {
                    line = line.Trim();

                    if (line.StartsWith(".Set "))
                    {
                        string prefix = ".Set DestinationDir=";

                        if (line.StartsWith(prefix))
                        {
                            string dir = line.Substring(prefix.Length);

                            Debug.WriteLine("dir " + dir);

                            currentDirectory = FindDirectory(dir);

                            Debug.WriteLine(" as " + currentDirectory.Id);
                        }
                    }
                    else
                    {
                        String baseName = BaseName(line);

                        Debug.WriteLine("file " + line + " to " + currentDirectory.Id + " as " + baseName);

                        XmlElement file = FindFile(currentDirectory, baseName);

                        if (file == null)
                        {
                            file = FindFile(currentDirectory, null);

                            XmlElement newFile = (XmlElement)file.CloneNode(true);

                            file.ParentNode.InsertAfter(newFile, file);

                            file = newFile;
                        }

                        file.SetAttribute("Id", "C_"+currentDirectory.Name+"_"+baseName);

                        XmlNodeList fileNodes = file.GetElementsByTagName("File", WixNamespace);

                        int i = 0;

                        while (i < fileNodes.Count)
                        {
                            XmlElement fileElement = (XmlElement)fileNodes.Item(i++);

                            fileElement.SetAttribute("Id", "F_" + currentDirectory.Name + "_" + baseName);
                            fileElement.SetAttribute("Source", line);
                        }
                    }
                }
            }

            if ((headerFile != null)&&(packageName!=null))
            {
                using (StreamReader reader = new StreamReader(headerFile))
                {
                    string line;
                    string match = "#define DEPVERS_" + packageName + "_INT4 ";

                    while ((line = reader.ReadLine()) != null)
                    {
                        line = line.Trim();

                        if (line.StartsWith(match))
                        {
                            String vers = line.Substring(match.Length).Replace(',', '.');

                            XmlNodeList productNodes = doc.SelectNodes("/wi:Wix/wi:Product", nsmgr);

                            int count = productNodes.Count;

                            int i = 0;

                            while (i < count)
                            {
                                XmlElement product = (XmlElement)productNodes.Item(i++);

                                product.SetAttribute("Version", vers);

                                XmlNodeList upgrades = product.SelectNodes("wi:Upgrade/wi:UpgradeVersion", nsmgr);

                                int upCount = upgrades.Count;

                                int j = 0;

                                while (j < upCount)
                                {
                                    XmlNode upNode = upgrades.Item(j++);

                                    XmlElement upgradeVersion = (XmlElement)upNode;

                                    upgradeVersion.SetAttribute("Maximum", vers);
                                }

                                XmlNodeList packages = product.SelectNodes("wi:Package", nsmgr);

                                int packCount = packages.Count;

                                int k = 0;

                                while (k < packCount)
                                {
                                    XmlNode upNode = packages.Item(k++);

                                    XmlElement package = (XmlElement)upNode;

                                    string platform = package.GetAttribute("Platform");

                                    package.SetAttribute("Comments", platform+"/"+vers);
                                }
                            }
                        }
                    }
                }
            }

            using (FileStream str = new FileStream(outFile, FileMode.Create, FileAccess.Write))
            {
                doc.Save(str);
            }
        }

        private static DirectoryEntry FindDirectory(string dir)
        {
            string baseName = BaseName(dir);

            int i = 0;

            while (i < directories.Count)
            {
                DirectoryEntry e = directories[i++];

                if (baseName.Equals(e.Name))
                {
                    return e;
                }
            }

            return null;
        }

        static DirectoryEntry AddDirectory(DirectoryEntry parent,XmlNode node)
        {
            XmlElement el = (XmlElement)node;

            DirectoryEntry entry = new DirectoryEntry();

            directories.Add(entry);

            entry.Id = el.GetAttribute("Id");
            entry.Name = el.GetAttribute("Name");
            entry.Parent = parent;

            int i = 0;

            while (i < el.ChildNodes.Count)
            {
                XmlNode child = el.ChildNodes.Item(i++);

                if (child.NodeType==XmlNodeType.Element)
                {
                    XmlElement cel = (XmlElement)child;

                    string name = cel.LocalName;

                    if (name.Equals("Directory"))
                    {
                        DirectoryEntry dir = AddDirectory(entry, cel);

                        if (dir!=null)
                        {
                            entry.Children.Add(dir);
                        }
                    }
                }
            }

            return entry;
        }

        static string BaseName(string s)
        {
            int i = s.Length;

            while (i-->0)
            {
                char c = s[i];

                if ((c == '/')||(c=='\\'))
                {
                    return s.Substring(i + 1);
                }
            }

            return s;
        }

        static XmlNodeList GetFiles()
        {
            return doc.SelectNodes("/wi:Wix/wi:Fragment/wi:ComponentGroup/wi:Component", nsmgr);
        }

        static XmlElement FindFile(DirectoryEntry dir,string name)
        {
            XmlNodeList files=GetFiles();

            int count = files.Count;

            int i = 0;

            while (i < count)
            {
                XmlElement el = (XmlElement)files.Item(i++);

                if (dir.Id.Equals(el.GetAttribute("Directory")))
                {
                    if ((name==null) || name.Equals(el.GetAttribute("Id")))
                    {
                        return el;
                    }
                }
            }

            return null;
        }
    }
}
