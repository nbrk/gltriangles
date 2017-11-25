module GLUTAbstraction where

import Graphics.UI.GLUT

import Types
import GLPipeline


glutPrepare :: IO ()
glutPrepare = do
  (progName, _args) <- getArgsAndInitialize
  initialDisplayMode $= [ RGBAMode ]
  initialWindowSize $= Size 512 512
  initialContextVersion $= (4, 3)
  initialContextProfile $= [ CoreProfile ]
  _ <- createWindow progName

  descriptor <- pipelineSetup
  displayCallback $= display descriptor


glutLoop :: IO ()
glutLoop = mainLoop

----

display :: Descriptor -> DisplayCallback
display (Descriptor triangles firstIndex numVertices) = do
  clear [ ColorBuffer ]
  bindVertexArrayObject $= Just triangles
  drawArrays Triangles firstIndex numVertices
  flush
