config = import \../compiler.config
import 
    \livescript-system

livescript-system
    ..watch = false
    ..clean = true
    ..config = config
    ..build!
