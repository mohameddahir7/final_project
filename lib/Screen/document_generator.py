
# # document_generator.py

# import sys
# from docx import Document
# from pptx import Presentation
# import base64

# def generate_docx(text):
#     doc = Document()
#     doc.add_paragraph(text)
#     doc.save('output.docx')
#     with open('output.docx', 'rb') as file:
#         result = base64.b64encode(file.read())
#     return result.decode('utf-8')

# def generate_pptx(text):
#     prs = Presentation()
#     slide = prs.slides.add_slide(prs.slide_layouts[5])
#     text_box = slide.shapes.add_textbox(left=0, top=0, width=prs.slide_width, height=prs.slide_height)
#     text_frame = text_box.text_frame
#     p = text_frame.add_paragraph()
#     p.text = text
#     prs.save('output.pptx')
#     with open('output.pptx', 'rb') as file:
#         result = base64.b64encode(file.read())
#     return result.decode('utf-8')

# if __name__ == '__main__':
#     command = sys.argv[1]
#     text = sys.argv[2]
#     if command == 'docx':
#         result = generate_docx(text)
#         print(result)
#     elif command == 'pptx':
#         result = generate_pptx(text)
#         print(result)



from flask import Flask, request
from document_generator import generate_docx, generate_pptx
import json

app = Flask(_name_)

@app.route('/generate_docx', methods=['POST'])
def generate_docx_api():
    text = request.form['text']
    result = generate_docx(text)
    return json.dumps({'result': result})

@app.route('/generate_pptx', methods=['POST'])
def generate_pptx_api():
    text = request.form['text']
    result = generate_pptx(text)
    return json.dumps({'result': result})

if _name_ == '_main_':
    app.run(debug=True)