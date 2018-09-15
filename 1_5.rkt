;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1_5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define r 27)
(define w (/ r 2))
(define h (* r 2))

(overlay/xy
 (circle r "solid" "green")
 (* (/ 3 4) r) w
 (rectangle w h "solid" "brown"))