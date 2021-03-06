import Foundation
import XCTest

class SimpleCipherTest: XCTestCase {
    
    func test_cipher_encode(){
        let cipher = Cipher()
        let plaintext = "aaaaaaaaaa"
        let expected  = cipher.key.substringToIndex(advance(cipher.key.startIndex, 10))
        XCTAssertEqual(expected, cipher.encode(plaintext) )
    }
    
    func test_cipher_decode(){
        let cipher = Cipher()
        let plaintext = "aaaaaaaaaa"
        let expected  = cipher.key.substringToIndex(advance(cipher.key.startIndex, 10))
        XCTAssertEqual(plaintext, cipher.decode(expected) )
    }
    
    func test_cipher_reversible(){
        let cipher = Cipher()
        let plaintext = "abcdefghij"
        XCTAssertEqual(plaintext, cipher.decode(cipher.encode(plaintext)))
    }
}

class SimpleCipherTestIncorrectKey: XCTestCase {
    
    func test_cipher_with_caps_key(){
        XCTAssertTrue(Cipher(key: "ABCDEF") == nil)
    }
    
    func test_cipher_with_numeric_key(){
        XCTAssertTrue(Cipher(key: "12345") == nil)
    }
    
    func test_cipher_with_empty_key(){
        XCTAssertTrue(Cipher(key: "") == nil)
    }
}

class SimpleCipherTestSubstitution: XCTestCase {
    
    let cipher = Cipher(key: "abcdefghij")!
    
    func test_cipher_key_is_as_submitted(){
        XCTAssertEqual(cipher.key, "abcdefghij")
    }
    
    func test_cipher_encode(){
        let plaintext = "aaaaaaaaaa"
        let ciphertext = "abcdefghij"
        XCTAssertEqual(ciphertext, cipher.encode(plaintext) )
    }
    
    func test_cipher_decode(){
        let plaintext = "aaaaaaaaaa"
        let ciphertext = "abcdefghij"
        XCTAssertEqual(plaintext, cipher.decode(ciphertext)  )
    }
    
    func test_cipher_reversible(){
        let plaintext = "abcdefghij"
        XCTAssertEqual(plaintext, cipher.decode(cipher.encode(plaintext)))
    }
    
    func test_double_shift_encode(){
        let plaintext = "iamapandabear"
        let ciphertext = "qayaeaagaciai"
        XCTAssertEqual(ciphertext, Cipher(key: "iamapandabear")?.encode(plaintext) ?? "" )
    }
    
    func test_cipher_encode_wrap(){
        let plaintext = "zzzzzzzzzz"
        let ciphertext = "zabcdefghi"
        XCTAssertEqual(ciphertext, cipher.encode(plaintext) )
    }
}

class SimpleCipherTestPseudoShift: XCTestCase {
    
    let cipherPseudo = Cipher(key: "dddddddddd")!
    
    func test_cipher_encode(){
        let plaintext = "aaaaaaaaaa"
        let ciphertext = "dddddddddd"
        XCTAssertEqual(ciphertext, cipherPseudo.encode(plaintext) )
    }
    
    func test_cipher_decode(){
        let plaintext = "aaaaaaaaaa"
        let ciphertext = "dddddddddd"
        XCTAssertEqual(plaintext, cipherPseudo.decode(ciphertext) )
    }
    
    func test_cipher_reversible(){
        let plaintext = "abcdefghij"
        XCTAssertEqual(plaintext, cipherPseudo.decode(cipherPseudo.encode(plaintext)) )
    }
    
}
