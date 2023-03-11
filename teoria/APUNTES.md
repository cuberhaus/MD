> help()
> demo()
> ls()
character(0)
> a <- 5
> a
[1] 5
> ls()
[1] "a"

**2. Preprocessing** 
Queremos datos de calidad. 

1. [FEATURE SELECTION]: Seleccionar los datos que consideremos importantes. Get a DIMENSIONALITY REDUCTION. 

2. [STADISTICAL SAMPLING]: Si hay mucho sample (n): hay que seguir una STADISTICAL SAMPLING para coger una pequena parte de la poblacion. 

3. [REDUNDANCY DATA]: Para var/features. Explotatory analisis, basics statistic. Eliminar los reduntantes y representar los mas relevantes.
    * visualization: plots, barplots, recharts, correlation matrix, contigency tables. 
    
    NUMERICAL FEATURES: poner en grafica dos features(variables) numericas,  si la grafica presenta una relacion lineal incluso si hay algun punto fuera de lo normal, se ve que hay una relacion entre las dos variables (linial relation ship). Si hace una curba, entonces tiene una polinomical relation ship. Si no sigue nigun Patron, las var no tienen relacion. 

    CATEGORICAL FEATURES(var plots) : eje x: categoria A, B, C, ... Eje y: frecuencia. Si presenta una distribucion por niveles, y hay muchos niveles que sus valores estan muy cerca, entonces podemos combinarlos en un nivel. Si tenemos 80% de datos con niveles muy bajos y muy cercanos, podemos coger solo los otros 20% mas varibles, y estudiar solo 20%. 

    * statistic inference

4. [TECHNICAL REVIEW OF DATA]: revisar que los valores en cada columna son iguales. 

5. [MISSING DATA]: En algun caso tenemos que encontrar algun valor para estos datos. Tenemos algunos estrategias: 
    * Si el database tiene menos de 5% de missing data: lo podemos eliminar e ignorar, pero dependiendo de los samples que tienes, por eso solo se usa en Large databases. NO CONSIDER ARTIFICIAL INDIVIDUES (altificial rows). Si tienes una columna con mucha MISSING DATA, lo podemos eliminar. 

    * Type missing data (Imputation)
        * MCAR: Missing completely at random data, not a clear INTENSION to make this misstake. Create artificial value, SEX: ''
        * MAR: With intension, SEX: NA, pero podemos usar el nombre de la persona para determinar el sexo.
        * MNAR: si no es random, es dato no es valido, y ir al principio y recolectar los datos otra vez. 

        - Si tenemos MCAR o MAR -> IMPUTATION: si num fratures, usar average o median. categorical features: MODE, or create new category UNKNOW. also get the missing data using relation ship, like names&sex.

        * KNN METHOD: Usar toda la  database para calcular missing data, calculando distance between individus in DB1 and DB2. Usaremos common featues en los DBs.
        * Usar INTERPOLACION, es decir usar los datos cercanos para 'inventar' missing data. 

    * Outlier: fuera de relacion (very different behaviour to others), hay que detectarlos, y hacer desiciones de los outliers. NOT REMOVE OUTLIERS. because outliers are telling us where occurs the problems. 
        * Use BOXPLOT or CLASSICAL PLOTS to found outliers. PCA -> tool for detect outliers. BAR PLOTS

    ----------------------------------------------------------------

    Quizz: Introduction, preprocessing, PCA

    **After preprocessing**
    
    * COMPARE OUR RESULTS: analizar las graficas(e.g de un feature) con los datos origiales y compararlos con los datos After preprocessing. Para que la imputacion sea correcta, las dos graficas deben tener un comportamiento muy parecido. 

    * FACTORIAL ANALYSIS: Despues de Preprocessing tenemos la siguiente informacion: X1 correlated with X3, Redundancy X4 and X7, Some features are more important than others. 
    -> En este paso queremos reducir el taman.o de los features(Xi). La nueva dimension Rj << Xi. Rj es una aproximacion de Xi, j mejor que sea entre 2 y 3 dimensiones, para una mejor representacion con graficas. 
        * Usaremos PCA(principal component analysis): Se conserva los individuos (samples), pero con menor nuemro de features(Xi). Con algebra linear conseguir INDEPENDENCE WITH PCs. Si PC1 y PC2 tiene un angula de 90 grados -> es INDEPENDENCE. Idea: MAXIMIZE the variability with components that linear combinations independent. SVD(spectral Descomposition) -> COVariance. Correlation matrix. Ejemplo: PC1 = uX1 + dX2 ....
        
        * Tendremos K factores que seran combinacion lineal de variables originales. 

        
        * Conclusion:  
            1. Relationships between all p features and components, in only one step.     
            
            2. Latent variables(PCA MOST IMPORTANT) -> Breaf descriptions about your PCs

            3. REDUCTION of dimension-> for others methods. 

        
        * Two categorical featues -> CA corresponding aplica

        * Input for PCA -> Euclidian distance for individus(rows), features (colums) get correlation and covariance. Need to be NORMALIZED (Xi - X)/sigma/  (X is average). for similar feature "CENTER" Xi - X.  
        

-------------------------------------------------------------

CLUSTERING: Method, distances, aggregation

method: partition -> k-means, herarchical -> ASC or DESCEND








