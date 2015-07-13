class PartsController < ApplicationController

  def initialize
    @best = BestBuy.new
  end

  def cpu
    result = @best.populate_list('abcat0507010')
    render json: result
  end

  def ram
    result = @best.populate_list('abcat0506000')
    render json: result
  end

  def motherboard
    result = @best.populate_list('abcat0507008')
    render json: result
  end

  def psu
    result = @best.populate_list('abcat0507009')
    render json: result
  end

  def gpu
    result = @best.populate_list('abcat0507009')
    render json: result
  end

  def hard_drive
    result = @best.populate_list('pcmcat270900050001')
    render json: result
  end

  def solid_state
    result = @best.populate_list('pcmcat201300050005')
    render json: result
  end

  def computer_case
    result = @best.populate_list('abcat0507006')
    render json: result
  end
end
