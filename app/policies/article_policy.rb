class ArticlePolicy < ApplicationPolicy
	
  def permitted_attributes
	%i[title text image tags]
  end 

  def update?
  	record.author == user
  end

  def destroy?
  	record.author == user
  end
  def edit?
  	update?
  end

end