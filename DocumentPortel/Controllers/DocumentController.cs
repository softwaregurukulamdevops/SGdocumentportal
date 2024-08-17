using DocumentPortel.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DocumentPortel.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DocumentController : Controller
    {
        public readonly TrainingDBContext trainingDBContext;
        public DocumentController(TrainingDBContext _trainingDBContext)
        {
            trainingDBContext = _trainingDBContext;
        }
        [HttpGet("GetDocumentDetails")]
        public List<Document> GetDocumentDetails()
        {
            List<Document> lstDocument = new List<Document>();
            try
            {
                lstDocument = trainingDBContext.Document.ToList();
                return lstDocument;
            }
            catch (Exception ex)
            {
                lstDocument = new List<Document>();
                return lstDocument;
            }
        }
        [HttpPost("AddDocument")]
        public string AddDocument(Document document)
        {
            string message = string.Empty;
            try
            {
                if (!string.IsNullOrEmpty(document.DocumentName))
                {
                    trainingDBContext.Add(document);
                    trainingDBContext.SaveChanges();
                    message = "Document added successfully";
                }
                else
                    message = "Document Name required.";

            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return message;
        }
    }
}
