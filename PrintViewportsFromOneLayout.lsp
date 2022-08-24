;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                               ;
;              Viewports To PDF from one layout                 ;
;                                                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun C:PrintKnez ()
      (setq m 0)                                                  ;First number
      (setq selectionSet (ssget "x" (list '(0 . "VIEWPORT"))))    ;selectionSet of Viewports
      (setq layoutNumber (sslength selectionSet))                 ;layoutNumber 
      (setq n (- layoutNumber 2))                                 ;Number of Viewports - 2 for some reasons of AutoCAD (autoCAD give two more viewports in one .dwg file)
      (setq imeFajla (getvar "DWGPREFIX"))                        ;Name of the file for pdf
      (setq PT1 (getpoint "\nPick Location of First Point: "))    ;First point
      (setq PT1X (car PT1))                                       ;X coordinate for PT1
      (setq PT1Y (cadr PT1))                                      ;Y coordinate for PT1
      (setq PT2 (getpoint "\nPick Location of Secound Point: "))  ;Secound point
      (setq PT2X (car PT2))                                       ;X coordinate for PT2
      (setq PT2Y (cadr PT2))                                      ;Y coordinate for PT2
      (setq userLength (- PT2X PT1X))                             ;Length of the paper
      (setq userWidth (- PT2Y PT1Y))                              ;nigde se ne pominje, ali neka ostane za sada 
  (while (< m n)                                                  ;While start
    (setq Ax (+ PT1X (* m userLength)))                           ;calculate first point of each layout
    (setq a (list Ax PT1Y))                                       ;coordinate of first point
    (setq Bx (+ PT2X (* m userLength)))                           ;calculate first point of each layout
    (setq b (list Bx PT2Y))                                       ;coordinate of secound point
    (prin1 a)
    (prin1 b)
    (command "_.-PLOT"                                            ;command "PLOT"
      "Yes"                                                       ;Detailed plot configuration? [Yes/No] <No>: No
      ""                                                          ;Enter a layout name or [?] <Layout1>:
      "DWG To PDF.pc3"                                            ;Enter an output device name or     
      "ISO full bleed A3 (420.00 x 297.00 MM)"                                   ;Enter paper size or
      "M"                                                         ;Enter paper units
      "L"                                                         ;Enter drawing orientation
      "No"                                                        ;Plot upside down?
      "W"                                                         ;Enter plot area
      a                                                           ;Enter lower left corner of window
      b                                                           ;Enter upper right corner of window
      ""                                                          ;Enter plot scale 
      ""                                                          ;Enter plot offset (x,y)
      "Yes"                                                       ;Plot with plot styles?
      ""                                                          ;Enter plot style table name or
      ""                                                          ;Plot with lineweights?
      "Yes"                                                       ;Scale lineweights with plot scale? 
      "No"                                                        ;Plot paper space first?
      "No"                                                        ;Hide paperspace objects?
      (strcat imeFajla "Layout" "_" (rtos m) ".pdf")              ;Directory to save  
      "yes"                                                       ;Write the plot to a file
      "Yes"                                                       ;Save changes to page setup
      "YES"                                                       ;Proceed with plot?
    )                                                             ;command plot
  (setq m (+ m 1)))                                               ;While end
)                                                                ;defun C:test
(princ
    (strcat
        (menucmd "M=$(edtime,$(getvar,date),DDDD\",\" D MONTH YYYY)")
        "\n Pozdrav"
        "\n Ukucajte \"PrintKnez\" da ukljucite funkciju"
    )
)