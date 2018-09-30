;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |51|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define LIGHT_RAD 25)
(define SIZE (+ (* LIGHT_RAD 2) 10))
(define CENTER (/ SIZE 2))
(define BG (rectangle SIZE SIZE "solid" "black"))
(define MTSCN (place-image BG CENTER CENTER (empty-scene SIZE SIZE)))

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; WorldState -> WorldState
; increases with every clock tick
(check-expect (tock 3) 2)
(define (tock s)
  (- s 1))

; WorldState -> NumTrafficLight
; uses WorldState to produce one of 3 possible states
(check-expect (get-state 2) 2)
(check-expect (get-state 4) 1)
(check-expect (get-state 9) 0)
(define (get-state s)
  (modulo s 3))

; NumTrafficLight -> TrafficLight
; maps numeric state to TrafficLight string
(check-expect (num2light 0) "red")
(check-expect (num2light 1) "yellow")
(check-expect (num2light 2) "green")
(define (num2light s)
  (cond [(= 0 s) "red"]
        [(= 1 s) "yellow"]
        [(= 2 s) "green"]))

; WorldState -> Boolean
; returns true when WorldState is 0
(check-expect (end? 10) #false)
(check-expect (end? 0) #true)
(define (end? s)
  (= s 0))

; TrafficLight -> Image
; outputs a circle of the color indicated by TrafficLight
(check-expect (render 0)
              (place-image (circle LIGHT_RAD "solid" "green") CENTER CENTER MTSCN))
(check-expect (render 1)
              (place-image (circle LIGHT_RAD "solid" "red") CENTER CENTER MTSCN))
(check-expect (render 2)
              (place-image (circle LIGHT_RAD "solid" "yellow") CENTER CENTER MTSCN))
(define (render s)
  (place-image (circle LIGHT_RAD
                       "solid"
                       (traffic-light-next (num2light (get-state s))))
               CENTER
               CENTER
               MTSCN))

(define (main s)
  (big-bang s
    [to-draw render]
    [on-tick tock]
    [stop-when end?]))