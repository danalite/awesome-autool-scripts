### Tips
- Source: https://github.com/jbantony/Object-Detection-Counter-API

```bash
# Build docker
cd Object-Detection-Counter-API
docker build -t od-api .

# Run docker non-stop mode (serving on localhost:6111)
docker run -ti --rm -p 5111:5111 od-api 
```


### Example Output
- POST test image to API endpoint 

```bash
curl -X POST -F "file=@$PWD/cars.jpg" http://localhost:5111/detect/
```

```json
{"filename":"traveling-for-memorial-day-weekend-what-you-should-know.jpg","detection results":{"detected objects":{"label":["car","car","truck","truck","car","car","car","car","car","car","car","car","truck","car","car","car","car","car","car","car","car","car","car","car","car","car","car","car","car","car","car","car","car","car"],"confidence":[76,68,95,75,79,54,85,76,54,89,72,59,56,85,92,90,92,75,55,88,81,73,65,90,68,84,87,93,65,90,87,93,94,70],"boxes":[[4,17,1261,545],[217,477,107,105],[927,481,125,117],[67,599,173,129],[280,669,152,111],[311,245,51,33],[150,284,65,48],[213,288,70,53],[1004,279,64,55],[289,312,70,51],[24,332,77,52],[857,318,57,48],[1075,306,103,79],[109,336,88,70],[226,347,82,58],[381,342,68,46],[894,346,66,53],[1014,350,79,56],[478,360,67,54],[793,361,68,53],[335,386,77,60],[35,385,80,77],[460,403,73,60],[686,413,74,63],[1131,416,71,72],[137,428,91,76],[871,432,83,74],[1013,427,97,73],[0,462,31,83],[729,477,95,62],[383,507,104,98],[754,525,100,77],[776,594,134,101],[836,726,145,74]]},"counts":{"car":31,"truck":3},"image height":800,"image width":1200}}        
```