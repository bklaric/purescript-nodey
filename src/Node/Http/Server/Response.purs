module Node.Http.Server.Response where

import Prelude

import Foreign (Foreign)
import Data.Nullable (Nullable)
import Effect (Effect)
import Node.Errors (Error)
import Node.Events.Event (Event(..))
import Node.Events.EventEmitter (class EventEmitter)
import Node.Events.EventEmitter as EventEmitter
import Node.Stream.Writable (class Writable)
import Node.Stream.Writable as Writable
import Undefined (undefined)
import Unsafe.Coerce (unsafeCoerce)

foreign import data Response :: Type

instance eventEmitterResponse :: EventEmitter Response where
    on                  = EventEmitter.defaultOn
    once                = EventEmitter.defaultOnce
    prependListener     = EventEmitter.defaultPrependListener
    prependOnceListener = EventEmitter.defaultPrependOnceListener
    removeListener      = EventEmitter.defaultRemoveListener
    removeAllListeners  = EventEmitter.defaultRemoveAllListeners
    emit                = EventEmitter.defaultEmit
    listeners           = EventEmitter.defaultListeners
    listenerCount       = EventEmitter.defaultListenerCount
    getMaxListeners     = EventEmitter.defaultGetMaxListeners
    setMaxListeners     = EventEmitter.defaultSetMaxListeners
    eventNames          = EventEmitter.defaultEventNames

instance writableResponse :: Writable Response where
    writableHighWaterMark   = Writable.defaultWritableHighWaterMark
    writableLength          = Writable.defaultWritableLength
    cork                    = Writable.defaultCork
    uncork                  = Writable.defaultUncork
    write                   = Writable.defaultWrite
    end                     = Writable.defaultEnd
    destroy                 = Writable.defaultDestroy

foreign import addTrailers ::
    Foreign -> Response -> Effect Unit

foreign import finished ::
    Response -> Effect Boolean

foreign import getHeader ::
    String -> Response -> Effect String

foreign import getHeaderNames ::
    Response -> Effect (Array String)

foreign import getHeaders ::
    Response -> Effect Foreign

foreign import hasHeader ::
    String -> Response -> Effect Boolean

foreign import headersSent ::
    Response -> Effect Boolean

foreign import removeHeader ::
    String -> Response -> Effect Unit

foreign import getSendDate ::
    Response -> Effect Boolean

foreign import setSendDate ::
    Boolean -> Response -> Effect Unit

foreign import setHeader ::
    String -> String -> Response -> Effect Unit

foreign import setHeader_ ::
    String -> Array String -> Response -> Effect Unit

foreign import defaultSetTimeout ::
    Int -> Effect Unit -> Response -> Effect Response

foreign import getStatusCode ::
    Response -> Effect Int

foreign import setStatusCode ::
    Int -> Response -> Effect Unit

foreign import getStatusMessage ::
    Response -> Effect (Nullable String)

foreign import setStatusMessage ::
    String -> Response -> Effect Unit

foreign import writeContinue ::
    Response -> Effect Unit

foreign import writeHead ::
    Int -> String -> Foreign -> Response -> Effect Unit

writeHead_ :: Int -> Foreign -> Response -> Effect Unit
writeHead_ statusCode headers =
    writeHead statusCode (unsafeCoerce headers) undefined

writeHead_' :: Int -> String -> Response -> Effect Unit
writeHead_' statusCode statusMessage =
    writeHead statusCode statusMessage undefined

writeHead__ :: Int -> Response -> Effect Unit
writeHead__ statusCode =
    writeHead statusCode undefined undefined

error :: Event Response (Error -> Effect Unit)
error = Event "error"

close :: Event Response (Effect Unit)
close = Event "close"

finish :: Event Response (Effect Unit)
finish = Event "finish"
