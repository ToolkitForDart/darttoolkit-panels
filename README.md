# Toolkit for Dart (panels)

Toolkit for Dart for Adobe Flash Professional allows you to publish a FLA to HTML by generating Dart code leveraging the StageXL library.

* <http://toolkitfordart.github.io>
* <http://dartlang.org>
* <http://www.stagexl.org>

## Sources organization

* **dart-dialog/** - Toolkit settings dialog
* **dart-panel/** - Toolkit panel

## Compiling the SWF panels
*Note: the SWF panels are only used to configure the output, they don't hold any publishing logic.*

### Fonts

For perfect UI fidelity, make sure you have both required fonts available on your system:

* Lucida Grande (OSX UI)
* Tahoma (Windows UI) 

### Compilation:

The SWF panels require Adobe Flash Professional CS6+ for compilation.

Open and compile:

* **darttoolkit-panels/dart-panel/SettingsDialog.fla**
* **darttoolkit-panels/dart-dialog/DartExportPanel.fla**

The SWFs will be generated directly in the same folder as the FLA - you must copy them manually to the appropriate location.
