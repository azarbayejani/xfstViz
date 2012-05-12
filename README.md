xfstViz
=======

You can use this script to convert the output of xfst's `print net` commmand
into a graphViz's DOT language. 

Running xfstViz
---------------

If you want to keep the dot file:
  
    xfst $regex | ./xfsttographviz.pl 

If all you want is a picture of the graph, the program can be run like so:

    xfst $regex | ./xfsttographviz.pl | dot -Tpng -o ${pngfile}.png

Just make sure that the xfst code has a `print net` statement at the end.

If you are running xfst interactively, you can copy the output of the program
from terminal and run it by piping `xclip` (linux) or `pbpaste` (mac) to it.

Let me know if you have any problems, feature requests, or questions. My
email is bobby.azarbayejani@gmail.com




Legal stuff
-----------

Copyright (c) 2011, Bobby Azarbayejani

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
