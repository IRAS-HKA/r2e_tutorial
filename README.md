# ready2educate cell tutorial

## First Time Setup - Robot

1. Boot up the robot
2. Boot up the Windows PC and log in with your RZ account
3. Download KRL sources from the `krl_sources` directory
4. Change IP in `krl_sources/EkiHwInterface.xml` and `krl_sources/EkiIOInterface.xml` to match the robot
   controller's IP (should be found on the robot cell somewhere)
5. Create new project on KUKA smartPAD (teach pendant) with KUKA smartHMI (touch screen user interface)
    - Open main menu (key with small robot in the bottom right on smartPAD or top left in
      smartHMI) &rarr; _Öffnen_
    - _Konfiguration_ &rarr; _Benutzergruppe_ &rarr; _Administrator_ (pass: kuka)
    - Open project management window (blue WorkVisual icon - gear with robot in it - on smartHMI)
        - "Ready2Educate" is the active project:
            - _Aktuellen Zustand sichern_
            - Name: "ros2_driver" &rarr; _OK_
            - select "ros2_driver" in _Verfügbare Projekte_ &rarr; _Entpinnen_
            - _Aktivieren_
        - "Ready2Educate" is not the active project:
            - Pin "Ready2Educate"
            - _Aktivieren_ &rarr; type in new project name, e.g. "ros2_driver" &rarr; confirm with _OK_
    - Confirm _Wollen Sie die Aktivierung des Projektes "ros2_driver" zulassen?_ with _Ja_
    - Confirm _Projektverwaltung_ panel _Wollen Sie fortfahren?_ with _Ja_
    - Wait until project is activated
6. Insert downloaded KRL sources in new project
    - On Windows PC open WorkVisual
    - Load newly created project "ros2_driver" from robot cell
        - _Datei_ &rarr; _Projekt öffnen_ &rarr; _Suchen_
        - Select cell with the corresponding IP
        - Select project "ros2_driver"
        - _Öffnen_
    - Navigate to "Dateien" tab in the left panel
    - Copy the files `krl_sources/EkiHWInterface.xml` and `krl_sources/EkiIOInterface.xml`, modified in step 4,
      to `IRAS-IRL<X>-KRC/Config/User/Common/EthernetKRL`  
      ![EKI Interface XMLs](readme_imgs/xmls.png)
    - Create new folder `IRAS-IRL<X>-KRC/KRC/R1/Program/ros2_driver`
    - Copy downloaded `krl_sources/kuka_eki_hw_interface.dat` and `krl_sources/kuka_eki_hw_interface.src`
      to `IRAS-IRL<X>-KRC/KRC/R1/Program/ros2_driver`  
      ![KRL Program Files](readme_imgs/krl_files.png)
7. Install program
    - Switch to user group _Administrator_ on smartPAD (see step 6)
    - Click _Installieren_ button  
      ![Install Button](readme_imgs/install_button.png)
    - _Weiter_ &rarr; _Weiter_ &rarr; _Weiter_ &rarr; _Ja_ on smartPAD &rarr;
      _Ja_ on smartPAD &rarr; _Fertigstellen_

## Start Hardware Interface on Robot

1. Switch to user group _Administrator_ on smartHMI
2. Activate project "ros2_driver" on smartHMI (if not already active)
    - Open project management window (blue WorkVisual icon (gear with robot in it) on smartHMI)
    - Select "ros2_driver" in _Verfügbare Projekte_ &rarr; _Entpinnen_
    - _Aktivieren_ &rarr; -> _Ja_
    - Wait until project is activated
3. On smartHMI navigate to  `R1/Program/ros2_driver`
4. Select `kuka_eki_hw_interface.src` &rarr; _Anwählen_
5. Select operating mode, e.g. Aut
    - Turn the switch on the smartPAD clockwise (keyswitch left to emergency stop button)
    - Select the operating mode on the smartHMI
    - Turn the switch back to the original position
6. Start program
    - Potentially change the robot's velocity (start symbol on top of hand symbol in the status bar at
      the
      top of the smartHMI) with the slider in the smartHMI or the +/- keys on the smartPAD
      (penultimate buttons on the right side)
    - Press start key (green play button) on the left side of the smartPAD multiple times, until the robot interpreter
      status indicator turns green
      (the area around the "R" in the status bar at the top of the smartHMI)
        - You potentially need to "Quitt" the robot by pressing the "Quitt" button on the robot cell
        - You need to activate the robot's drives if they are not active (grey "O" next to the "R" in the status bar at
          the top of the smartHMI)
            - click on the "O" in the status bar
            - click in "I" in the menu that pops up
    - If T1 or T2 operating mode is selected instead of Aut, one of the enabling switches on the rear of the smartPAD
      has
      to be held in center position and the start key has to be held constantly to continue running
      the program
