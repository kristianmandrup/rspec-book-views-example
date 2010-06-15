shared_examples_for "a template that renders the messages/form partial" do
  it "renders the messages/form partial" do
    view.stub(:_render_partial)
    view.should_receive(:_render_partial).
      with(hash_including(:partial => "form")) 
    render  
  end  
end
