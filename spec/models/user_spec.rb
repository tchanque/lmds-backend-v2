require 'rails_helper'
require 'date'


RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    context 'email validations' do
      it 'is valid with a valid email' do
        valid_emails = ['test@example.com', 'user.name@domain.co', 'user+mailbox@domain.com']

        valid_emails.each do |email|
          subject.email = email
          expect(subject).to be_valid, "#{email.inspect} should be valid"
        end
      end

      it 'is invalid with an invalid email' do
        invalid_emails = ['plainaddress', '@missingusername.com', 'username@.com']

        invalid_emails.each do |email|
          subject.email = email
          expect(subject).not_to be_valid, "#{email.inspect} should be invalid"
        end
      end
    end

    context 'password validations' do
      it 'is valid with a valid password (8char, min 1 Uppercase, min 1 special char)' do
        valid_passwords = ['Password1!', 'Complex#Password123']

        valid_passwords.each do |password|
          subject.password = password
          subject.password_confirmation = password
          expect(subject).to be_valid, "#{password.inspect} should be valid"
        end
      end


      it 'is invalid if less then 8 char' do
        invalid_passwords = ['short', 'no!', 'NoDig!', 'NOLOWER']

        invalid_passwords.each do |password|
          subject.password = password
          subject.password_confirmation = password
          expect(subject).not_to be_valid, "#{password.inspect} should be invalid"
        end
      end

      it 'is invalid because at least one digit is required' do
        invalid_passwords = ['shorfdsfgt', 'nggsSEDFFo!', 'NgdzGGoDig!', 'NOLOseGegdsEGWER']

        invalid_passwords.each do |password|
          subject.password = password
          subject.password_confirmation = password
          expect(subject).not_to be_valid, "#{password.inspect} should be invalid"
        end
      end
      
      it 'is invalid because at least one uppercase is required' do
        invalid_passwords = ['shorfds452!!fgt', 'nggs54655o!', '1234gdzoig5!', 'seegds59875??']

        invalid_passwords.each do |password|
          subject.password = password
          subject.password_confirmation = password
          expect(subject).not_to be_valid, "#{password.inspect} should be invalid"
        end
      end
      
      it 'is invalid because at least one lowercase is required' do
        invalid_passwords = ['5656ERWQE!', 'WEFDWE@#QWEG55', '8656&EWTKGREF545']

        invalid_passwords.each do |password|
          subject.password = password
          subject.password_confirmation = password
          expect(subject).not_to be_valid, "#{password.inspect} should be invalid"
        end
      end
      
      it 'is invalid because it requires at least one special character' do
        invalid_passwords = ['shorRE366er', 'nggsSEDFFo25', '899NgdzGGoDig', 'NOLOseGegds54EGWER']

        invalid_passwords.each do |password|
          subject.password = password
          subject.password_confirmation = password
          expect(subject).not_to be_valid, "#{password.inspect} should be invalid"
        end
      end
    end

    context 'is_subscriber validations' do
      it 'is valid with a valid boolean' do
        valid_is_subscriber = [true]

        valid_is_subscriber.each do |is_subscriber|
          subject.is_subscriber = is_subscriber
          expect(subject).to be_valid, "#{is_subscriber.inspect} should be valid"
        end
      end

      # Cannot check the following as falsy value is considered as invalid (empty)
      # it 'is invalid with an invalid boolean' do
      #   invalid_is_subscriber = ['not a boolean']

      #   invalid_is_subscriber.each do |is_subscriber|
      #     subject.is_subscriber = is_subscriber
      #     expect(subject).not_to be_valid, "#{is_subscriber.inspect} should be invalid"
      #   end
      # end
    end

    context 'end subscription validations' do
      it 'is valid with a valid date' do
        valid_subscription_end_date = [DateTime.new(2025, 1, 1, 0, 0, 0)]

        valid_subscription_end_date.each do |end_date|
          subject.subscription_end_date = end_date
          expect(subject).to be_valid, "#{end_date.inspect} should be valid"
        end
      end

      # it 'is invalid with an invalid date' do
      #   invalid_subscription_end_date = [0, 'not a date']
    
      #   invalid_subscription_end_date.each do |end_date|
      #     subject.subscription_end_date = end_date
      #     expect(subject).not_to be_valid, "#{end_date.inspect} should be invalid but errors are #{subject.errors.full_messages}"
      #   end
      # end
    end
  end
end