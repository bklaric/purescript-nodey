module Node.Stream.Readable.Events where

import Prelude

import Data.Array (snoc)
import Effect (Effect)
import Effect.Ref (modify, new, read)
import Foreign (Foreign)
import Node.Events.Event (Event(..))
import Node.Events.EventEmitter (on')
import Node.Stream.Readable (class Readable)

close :: forall readable. Readable readable =>
    Event readable (Effect Unit)
close = Event "close"

data' :: forall readable. Readable readable =>
    Event readable (Foreign -> Effect Unit)
data' = Event "data"

end :: forall readable. Readable readable =>
    Event readable (Effect Unit)
end = Event "end"

readable :: forall readable. Readable readable =>
    Event readable (Effect Unit)
readable = Event "readable"

readDataEvents :: forall readable. Readable readable =>
    (Foreign -> Effect Unit) -> Effect Unit -> readable -> Effect readable
readDataEvents dataListener endListener readable' = do
    readable'
    # on' data' dataListener
    >>= on' end endListener

collectDataEvents :: forall readable. Readable readable =>
    (Array Foreign -> Effect Unit) -> readable -> Effect readable
collectDataEvents endListener readable' = do
    streamData <- new ([] :: Array Foreign)
    readable' # readDataEvents
        (\eventData -> streamData # modify (flip snoc eventData) # void)
        (read streamData >>= endListener)
