{-
   Triangles.hs (adapted from triangles.cpp which is (c) The Red Book Authors.)
   Copyright (c) Sven Panne 2014 <svenpanne@gmail.com>
   This file is part of HOpenGL and distributed under a BSD-style license
   See the file GLUT/LICENSE

   Our first OpenGL program.
-}
import GLUTAbstraction


main :: IO ()
main = do
  glutPrepare

  glutLoop
