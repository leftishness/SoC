#lang racket

(define (random-change str) 
  (let ([op (random 3)])
    (let* ([pos (random (string-length str))]
           [char (integer->char (+ 33 (random 94)))]
           [new-str (string-copy str)])
      (cond
        [(= op 0)  
         (string-append (substring new-str 0 pos) (string char) (substring new-str pos))]
        [(= op 1)
         (if (> (string-length new-str) 1)
             (string-append (substring new-str 0 pos) (substring new-str (add1 pos)))
             new-str)]
        [else
         (string-set! new-str pos char)
         new-str]))))

(define (test-quine code)
  (with-handlers ([exn:fail? (lambda (e) #f)])
    (let ([output (call-with-output-string 
                    (lambda () (eval (read (open-input-string code)))))]
          [trimmed-code (string-trim code)])
      (equal? output trimmed-code))))

(define intron "// this is an intron")

(define original-code  
  "(define (random-change str) (let ([op (random 3)]) (let* ([pos (random (string-length str))] [char (integer->char (+ 33 (random 94)))] [new-str (string-copy str)]) (cond [(= op 0) (string-append (substring new-str 0 pos) (string char) (substring new-str pos))] [(= op 1) (if (> (string-length new-str) 1) (string-append (substring new-str 0 pos) (substring new-str (add1 pos))) new-str)] [else (string-set! new-str pos char) new-str]))))(define (test-quine code) (with-handlers ([exn:fail? (lambda (e) #f)]) (let ([output (call-with-output-string (lambda () (eval (read (open-input-string code)))))] [trimmed-code (string-trim code)]) (equal? output trimmed-code))))(define intron \"// this is an intron\")(define original-code \"THIS WILL BE REPLACED\")(define (quine code) (let ([mutated-code (string-append (random-change code) intron)]) (if (test-quine mutated-code) (begin (display \"Valid Quine Found:\") (newline) (display mutated-code) (newline)) (void)) (quine code)))(set! original-code (string-replace original-code \"THIS WILL BE REPLACED\" (string-append \"\\\"\" original-code \"\\\"\")))(quine original-code)")

(define (quine code)
  (let ([mutated-code (string-append (random-change code) intron)])
    (if (test-quine mutated-code)
      (begin
        (display "Valid Quine Found:") (newline)
        (display mutated-code)
        (newline))
      (void))
    (quine code)))

(set! original-code (string-replace original-code "THIS WILL BE REPLACED" (string-append "\"" original-code "\"")))
(quine original-code)
