module ItemSpliter

  def split(*fields)
    fields.each do |field|
      class_eval(<<-METOD
       before_validation do
         corection_title
       end

       def corection_title
         unless #{field}.nil?
         #{field}.strip!
         self.#{field} = #{field}.split.join(' ')
       end
       validates :#{field}, presence: true

      METOD
      )
    end
  end
end
