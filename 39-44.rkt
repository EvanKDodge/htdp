;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 39-44) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; all constants relating to CAR are defined in terms of WHEEL-RADIUS
(define WHEEL-RADIUS 15)
(define WHEEL-SPACE (* WHEEL-RADIUS 4))
(define WHEEL-Y-OFFSET (* WHEEL-RADIUS -1.5))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))
(define BODY-WIDTH (* WHEEL-RADIUS 8))
(define TOP-HEIGHT WHEEL-RADIUS)
(define TOP-WIDTH (* WHEEL-RADIUS 4))

(define CAR (overlay/offset (overlay/offset (circle WHEEL-RADIUS "solid" "black")
                                            WHEEL-SPACE 0
                                            (circle WHEEL-RADIUS "solid" "black"))
                            0 WHEEL-Y-OFFSET
                            (above (rectangle TOP-WIDTH TOP-HEIGHT "solid" "red")
                                   (rectangle BODY-WIDTH BODY-HEIGHT "solid" "red"))))

(define TREE (underlay/xy (circle WHEEL-RADIUS "solid" "green")
                          WHEEL-RADIUS (* WHEEL-RADIUS 1.5)
                          (rectangle (* WHEEL-RADIUS .2) (* WHEEL-RADIUS 2) "solid" "brown")))

(define Y-CAR (* WHEEL-RADIUS 3))
(define BG_WIDTH (* (image-width CAR) 10))
(define BG_HEIGHT (* WHEEL-RADIUS 6))
(define BACKGROUND (place-image TREE (/ BG_WIDTH 2) Y-CAR (empty-scene BG_WIDTH BG_HEIGHT)))
(define SPEED 5)

; WorldState -> WorldState
; moves the car by 3 pixels for every clock tick
; examples:
(check-expect (tock 20) 25)
(check-expect (tock 78) 83)
(define (tock ws)
  (+ ws SPEED))

; AnimationState is a Number
; the number of clock ticks since the animation started
(define (time-slice t)
  (+ t 1))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
(check-expect (render 0) (place-image CAR (- 0 (/ (image-width CAR) 2)) Y-CAR BACKGROUND))
(check-expect (render 50) (place-image CAR (- 250 (/ (image-width CAR) 2)) Y-CAR BACKGROUND))
(define (render t)
  (place-image CAR (- (* t SPEED) (/ (image-width CAR) 2)) Y-CAR BACKGROUND))

; WorldState String -> WorldState
; when a key is pressed, car moves back to the beginning
(check-expect (restart 50 "a") 0)
(check-expect (restart 300 "b") 0)
(define (restart t ke)
  0)

; WorldState Number Number String -> WorldState
; on a mouse click, car moves to x coordinate given by mouse
(check-expect (change-position 200 5 1 "button-up") 1)
(check-expect (change-position 200 1 1 "button-down") 200)
(define (change-position t x y me)
  (if (mouse=? me "button-up")
      (/ x SPEED)
      t))

; WorldState -> Boolean
; after each event, end? is evaluted to determine if the program should continue
(check-expect (end? (+ BG_WIDTH 1)) #true)
(check-expect (end? 0) #false)
(define (end? t)
  (> (* t SPEED) BG_WIDTH))

; WorldState -> WorldState
;launches the program from an initial state using big-bang
(define (main t)
  (big-bang t
    [on-tick time-slice]
    [to-draw render]
    [on-mouse change-position]
    [on-key restart]
    [stop-when end?]))