; Mapeli for a color match -game, written in hy.
;
; Mapeli is a 'ghost of a game'. A new kind of holiday chore.
; Entertain yourself and give the mapeli a new life.
; 
; The mapeli always holds a theme, containing
; a shadow of a game whose name it bears.
;
; In a well-written mapeli only thing that's needed
; to complete the mapeli is the reference manual of the
; programming language it's been written in.
;
; Of course, you need pygame to run this mapeli because python&hy doesn't
; have a standard graphics library. Overall mapelies aren't supposed to
; hide any important details with third party libraries either. 
;
; Mapelies rely on the fact that programming a game is often as fun as
; playing it. Do not complete them to publish and brag. Nevertheless a
; well-completed mapeli is capable of entertaining others. Be free to
; publish but keep in mind it is entirely optional for you.
; 
(import pygame)
(import random)
(pygame.display.init)
(pygame.font.init)
(pygame.mixer.init)

(setv font (pygame.font.Font None 32))
(setv sound (pygame.mixer.Sound "./Subsynth-modfilter.ogg"))
(defn color-brick [color]
    (setv brick (pygame.Surface '(20 20)))
    (pygame.draw.circle brick color [10 10] 10)
    brick)
(setv bricks
    [(color-brick '(255  80 80))
     (color-brick '(80  255 80))
     (color-brick '(80   80 255))
     (color-brick '(255 255 80))
     (color-brick '(255  80 255))
     (color-brick '(80  255 255))])
(setv level [])
(for [i (range 16)]
    (setv column [])
    (for [j (range 11)]
        (column.append (random.choice bricks)))
    (level.append column))
(setv screen (pygame.display.set_mode [320 240]))
(setv running True)
(pygame.display.set_caption "match color mapeli")

(while running
    (for [event (pygame.event.get)]
        (cond
            [(or
                (= event.type pygame.QUIT)
                (and
                 (= event.type pygame.KEYDOWN)
                 (= event.key pygame.K_ESCAPE)))
             (setv running False)]
            [(= event.type pygame.MOUSEBUTTONDOWN)
             (do
              (setv [x y] event.pos)
              (print x y)
              (sound.play))]))
    (screen.fill '(40 40 40))
    (for [[i column] (enumerate level)]
        (for [[j brick] (enumerate column)]
            (screen.blit brick [(* i 20) (- 200 (* j 20))])))
    (screen.blit
     (font.render (+ "score: " (str 15)) True '(255 255 255) '(80 80 80))
     [10 220])
    (pygame.display.flip))
