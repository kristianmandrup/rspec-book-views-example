shared_examples_for "a template that renders the messages/form partial" do
  it "renders the messages/form partial" do
    # template.should_receive(:render).with(
    #   :partial => "form", 
    #   :locals => { :message => assigns[:message] }
    # )
    render
  end  
end
