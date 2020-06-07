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
using System.Diagnostics;
using System.IO;
using System.IO.Compression;

namespace makezip
{
    class makezip
    {
        static void Main(string[] args)

        {
            string
                outFile = null,
                ddfFile = null,
                currentDirectory = null;

            {
                int i = 0;

                while (i < args.Length)
                {
                    string op = args[i++];

                    switch (op)
                    {
                        case "-o": outFile = args[i++]; break;
                        case "-d": ddfFile = args[i++]; break;
                        default:
                            throw new Exception("unknown option " + op);
                    }
                }
            }

            using (StreamReader reader = new StreamReader(ddfFile))
            {
                string line;

                using (FileStream outputStream=new FileStream(outFile, FileMode.Create, FileAccess.Write))
                {
                    using (ZipArchive archive=new ZipArchive(outputStream, ZipArchiveMode.Create, true))
                    {
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

                                    currentDirectory = dir;

                                    Debug.WriteLine(" as " + currentDirectory);
                                }
                            }
                            else
                            {
                                String baseName = BaseName(line);
                                String dest = currentDirectory + Path.DirectorySeparatorChar + baseName;

                                dest = dest.Replace('\\', '/');

                                Debug.WriteLine("file " + line + " to " + dest);

                                archive.CreateEntryFromFile(line, dest, CompressionLevel.Fastest);
                            }
                        }
                    }
                }
            }
        }

        static string BaseName(string s)
        {
            int i = s.Length;

            while (i-- > 0)
            {
                char c = s[i];

                if ((c == '/') || (c == '\\'))
                {
                    return s.Substring(i + 1);
                }
            }

            return s;
        }
    }
}
