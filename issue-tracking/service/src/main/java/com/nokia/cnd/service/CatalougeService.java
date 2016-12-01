package com.nokia.cnd.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.jboss.resteasy.plugins.providers.multipart.InputPart;
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;

import com.nokia.cam.testo.contentstore.api.ContentStore;
import com.nokia.cam.testo.contentstore.file.FileSystemContentStore;
import com.nokia.cam.testo.errorhandling.ErrorHandler;
import com.nokia.cam.testo.manifest.ManifestUtil;
import com.nokia.cam.testo.operations.OperationCreate;
import com.nokia.cam.testo.rest.model.TemplatePackageCreateParams;
import com.nokia.cam.testo.zip.ZipUtilsFactory;


@Path( "/v1" )
public class CatalougeService 
{

    @POST
    @Path( "/create" )
    @Consumes( "multipart/form-data" )
    @Produces( "application/json" )
    public Response createDataset(
        @Context HttpHeaders headers,
        MultipartFormDataInput binary )
    {
        try
        {
            System.out.println("Welcome to Catalouge Service");
            Map<String, List<InputPart>> formDataMap = binary.getFormDataMap();
            List<InputPart> inputParts = formDataMap.get( "csarFile" );
            InputStream inputStream = null;

            if( inputParts != null )
            {
                inputStream =
                    inputParts.get( 0 ).getBody( InputStream.class, null );
            }

            TemplatePackageCreateParams templateParam =
                new TemplatePackageCreateParams( inputStream );
            System.out.println( "File Directory--> " +
                System.getProperty( "user.dir" ) );
            ZipUtilsFactory zipFactory = new ZipUtilsFactory();
            ManifestUtil manifestUtil = new ManifestUtil();
            ContentStore contentStore = new FileSystemContentStore();
            ErrorHandler errorHandler = new ErrorHandler();
            manifestUtil.init();
            OperationCreate operationcreate =
                new OperationCreate( templateParam );
            operationcreate.initUtils(
                zipFactory, manifestUtil, contentStore, errorHandler );
            operationcreate.apply();

            inputStream.close();
        }
        catch( Exception e )
        {
            System.out.println("In Exception");
            e.printStackTrace();
        }
        return Response.ok().build();
    }


    @GET
    @Path( "/delete" )
    @Produces( MediaType.APPLICATION_JSON )
    public Response removeDataset( @Context HttpHeaders headers )
    {
        /*ManifestUtil manifestUtil = new ManifestUtil();
        ContentStore contentStore = new FileSystemContentStore();
        ErrorHandler errorHandler = new ErrorHandler();
        manifestUtil.init();
        OperationDelete delete = new OperationDelete( "HSS" );
        delete.initUtils( manifestUtil, contentStore, errorHandler );
        delete.delete();*/
        return Response.ok("yes..it's working").build();
    }
}
