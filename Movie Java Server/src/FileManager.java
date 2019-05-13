import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileManager {
    public static String pullAndCachefile(String url, String fileName, String filePath) throws IOException {
        if(!new File(filePath + File.pathSeparator + fileName +".txt").exists()) {
            String returnedString = HttpGet.get(url);
            if (!returnedString.isEmpty()) {
                File file;
                OutputStream outputStream = null;
                try {

                    file = new File(filePath + File.pathSeparator + fileName + ".txt");
                    if (!file.exists()) {
                        if (file.createNewFile()) {
                            System.out.println("created new cache file " +  file.getName());
                        }
                    }
                    outputStream = new FileOutputStream(file);
                    outputStream.write(returnedString.getBytes());
                } catch (IOException e) {
                    System.out.println(e);
                } finally {
                    if (outputStream != null) {
                        outputStream.close();
                    }
                    return returnedString;
                }
            }
        }else{
            File file;
            InputStream inputStream = null;
            try {
                file = new File(filePath + File.pathSeparator + fileName +".txt");
                inputStream = new FileInputStream(file);
                ByteArrayOutputStream byteArray = new ByteArrayOutputStream();
                int actualyRead;
                byte[] buffer = new byte[2];
                while((actualyRead = inputStream.read(buffer)) != -1){
                    byteArray.write(buffer, 0 , actualyRead);
                }
                return new String(byteArray.toByteArray());
            }catch (IOException e){
                System.out.println(e);
            }finally {
                if (inputStream != null) {
                    inputStream.close();
                }
            }
        }
        return null;
    }

    public static void checkIfOldFilesExistsAndRemove(String folderPath) {
        File folder = new File(folderPath);
        File[] allFiles = folder.listFiles();

        for (int i = 0; i < allFiles.length; i++) {
            String date = allFiles[i].getName();

            if(date.contains("-") && date.contains(".txt")) {
                date = date.replace(".txt", "");
                try {
                    Date fileDate =new SimpleDateFormat("yyyy-MM-dd").parse(date);
                    Date today = new Date(System.currentTimeMillis() - FinalsClass.ONE_DAY_IN_MILLIS );
                    if (fileDate.before(today)) {
                        if(allFiles[i].delete())
                            System.out.println("[SYSTEM] Old file found: " + allFiles[i].getName() + " and Successfully deleted");
                        else
                            System.out.println("[SYSTEM] Old file found: " + allFiles[i].getName() + " and could not be deleted, Please manual delete the file");
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
