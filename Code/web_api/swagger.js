
import swaggerAutogen from "swagger-autogen";

const outputFile = './docs/swagger.json'
const endpointsFiles = ['./routers/routes.js']

const doc = {
    info: {
        "version": "1.0.0",
        "title": "Plantemoji API",
        description: "Documentation automatically generated by the <b>swagger-autogen</b> module."
    },
    host: "localhost:4000",
    basePath: "/",
    schemes: ['http', 'https'],
    consumes: ['application/json'],
    produces: ['application/json'],// tells swagger the type of output content
    tags: [//a given goal, groups of endpoints
        {
            "name": "Path Planning"
        }
    ],
    definitions: {
        
    }}
            
    


swaggerAutogen(outputFile, endpointsFiles, doc);

