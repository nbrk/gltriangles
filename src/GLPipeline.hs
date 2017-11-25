module GLPipeline where

import Foreign.Marshal.Array(withArray)
import Foreign.Storable(sizeOf)
import Graphics.UI.GLUT

import Types
import Utils
import LoadShaders


pipelineSetup :: IO Descriptor
pipelineSetup = do
  triangles <- genObjectName
  bindVertexArrayObject $= Just triangles

  let vertices = [
        Vertex2 (-0.90) (-0.90),  -- Triangle 1
        Vertex2   0.85  (-0.90),
        Vertex2 (-0.90)   0.85 ,
        Vertex2   0.90  (-0.85),  -- Triangle 2
        Vertex2   0.90    0.90 ,
        Vertex2 (-0.85)   0.90 ] :: [Vertex2 GLfloat]
      numVertices = length vertices
      vertexSize = sizeOf (head vertices)

  arrayBuffer <- genObjectName
  bindBuffer ArrayBuffer $= Just arrayBuffer
  withArray vertices $ \ptr -> do
    let size = fromIntegral (numVertices * vertexSize)
    bufferData ArrayBuffer $= (size, ptr, StaticDraw)

  program <- loadShaders [
     ShaderInfo VertexShader (FileSource "triangles.vert"),
     ShaderInfo FragmentShader (FileSource "triangles.frag")]
  currentProgram $= Just program

  let firstIndex = 0
      vPosition = AttribLocation 0
  vertexAttribPointer vPosition $=
    (ToFloat,
     VertexArrayDescriptor 2 Float 0 (bufferOffset (firstIndex * vertexSize)))
  vertexAttribArray vPosition $= Enabled

  return $
    Descriptor triangles (fromIntegral firstIndex) (fromIntegral numVertices)


