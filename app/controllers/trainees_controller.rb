class TraineesController < ApplicationController
    def index
        @trainees = Trainee.all
    end
end