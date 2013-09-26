class Encryptor

  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    almost_there = Hash[characters.zip(rotated_characters)]
    almost_there.store("\n", "\n")
    almost_there
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split('')
    results = letters.collect do |letter|
      encrypt_letter(letter, rotation)
    end
    results.join
  end

  def decrypt(string, rotation)
    encrypt(string, -(rotation))
  end

  def encrypt_file(filename, rotation)
    binding.pry
    input = File.open(filename, "r")
    text = input.read
    encrypted = encrypt(text, rotation)
    out_file = filename + ".encrypted"
    output = File.open(out_file, "w")
    output.write(encrypted)
    output.close
  end

  def decrypt_file(filename, rotation)
    binding.pry
    input = File.open(filename, "r")
    text = input.read
    decrypted = decrypt(text, rotation)
    out_file = filename.gsub("encrypted", "decrypted")
    output = File.open(out_file, "w")
    output.write(decrypted)
    output.close
  end

  def crack(message)
    (' '..'z').to_a.size.times.collect do |attempt|
      decrypt(message, attempt)
    end
  end

end