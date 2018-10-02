;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname intervals-sample) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define UFO_X (/ WIDTH 2))
(define TEXT_X 240)
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green")
                     (ellipse 40 10 "solid" "green")))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
    [on-tick nxt]
    [to-draw render]
    [stop-when end?]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 12)
(define (nxt y)
  (+ y 1))

; WorldState -> Boolean
; determines if UFO has landed (and program is finished)
(check-expect (end? 50) #false)
(check-expect (end? (+ HEIGHT 1)) #true)
(define (end? y)
  (> y HEIGHT))

; WorldState -> StatusString
; computes string based on value of y coord.
; StatusString is a String consisting of one of the following values:
; "descending" if y < CLOSE
; "closing-in" if y >= CLOSE and y<HEIGHT
; "landed" if y >=HEIGHT
(check-expect (status 0) "descending")
(check-expect (status CLOSE) "closing-in")
(check-expect (status HEIGHT) "landed")
(define (status y)
  (cond [(< y CLOSE) "descending"]
        [(and (>= y CLOSE) (< y HEIGHT)) "closing-in"]
        [else "landed"]))

; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-images (list UFO (text "descending" 20 "blue"))
                                        (list (make-posn UFO_X 11) (make-posn TEXT_X 10))
                                        MTSCN))
(check-expect (render 70) (place-images (list UFO (text "closing-in" 20 "blue"))
                                        (list (make-posn UFO_X 70) (make-posn TEXT_X 10))
                                        MTSCN))
(check-expect (render 100) (place-images (list UFO (text "landed" 20 "blue"))
                                        (list (make-posn UFO_X 100) (make-posn TEXT_X 10))
                                        MTSCN))
(define (render y)
  (place-images (list UFO (text (status y) 20 "blue"))
                (list (make-posn UFO_X y) (make-posn TEXT_X 10))
                MTSCN))