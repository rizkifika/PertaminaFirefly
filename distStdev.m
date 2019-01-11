function stdevi = distStdev(load)
z=numel(load);
dev=0;
for i=1:z
    faktor = load(i)/25;
    simpangan = (faktor-8);
    simpanganSquare = simpangan*simpangan;
    dev = dev+simpanganSquare;
end
stdevi = dev/z;
stdevi = sqrt(stdevi);
end