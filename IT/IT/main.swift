/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Cocoa


func main() {
    let app = NSApplication.shared
    let delegate = AppDelegate()
    
    app.delegate = delegate
    
    _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
}
main()
