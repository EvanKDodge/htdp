;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |47|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define RECT_W 100)
(define RECT_H (* RECT_W .2))
(define OL_GAP 4)

; HappinessLevel is a Number (Max=100;Min=0)
; Decreases by .1 with each clock tick
; HappinessLevel -> HappinessLevel
(check-expect (tock 100) 99.9)
(check-expect (tock 1) .9)
(check-expect (tock .05) 0)
(check-expect (tock 0) 0)
(define (tock h)
  (cond [(>= h .1) (- h .1)]
        [else 0]))

; HappinessLevel String -> HappinessLevel
; pressing up arrow causes happiness to increase by 1/3
; pressing down arrow causes happiness to increase by 1/5
(check-expect (give-love 0 "up") (/ 100 3))
(check-expect (give-love 1 "down") (+ 1 20))
(check-expect (give-love 100 "up") 100)
(check-expect (give-love 100 "down") 100)
(define (give-love h ke)
  (cond [(key=? ke "up") (min 100 (+ h (/ 100 3)))]
        [(key=? ke "down") (min 100 (+ h (/ 100 5)))]
        [else h]))

; HappinessLevel -> Image
; take the current happiness level and display as
;  a red rectangle on a black background
(check-expect (render 10) (overlay/align "left" "middle"
                                         (rectangle (* RECT_W .1) RECT_H "solid" "red")
                                         (empty-scene RECT_W RECT_H)))
(check-expect (render 100) (overlay/align "left" "middle"
                                         (rectangle (* RECT_W 1) RECT_H "solid" "red")
                                         (empty-scene RECT_W RECT_H)))
(check-expect (render 0) (overlay/align "left" "middle"
                                         (rectangle (* RECT_W 0) RECT_H "solid" "red")
                                         (empty-scene RECT_W RECT_H)))
(define (render h)
  (overlay/align "left" "middle"
                 (rectangle (* RECT_W (/ h 100)) RECT_H "solid" "red")
                 (empty-scene RECT_W RECT_H)))

(define (gauge-prog h)
  (if (and (>= h 0) (<= h 100))
      (big-bang h
        [on-tick tock]
        [to-draw render]
        [on-key give-love])
      "Use values between 0 and 100"))