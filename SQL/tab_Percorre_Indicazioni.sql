create table percorre(
	PER_ITI_Id integer,
	PER_GRU_Id integer,
	PER_DataPartenza datetime,
	FOREIGN KEY(PER_ITI_Id) references itinerari(ITI_Id),
	FOREIGN KEY(PER_GRU_Id) references gruppi(GRU_Id),
	PRIMARY KEY(PER_ITI_Id, PER_GRU_Id)
);
create table indicazioni(
 	IND_Id AUTO INCREMENT PRIMARY KEY,
	IND_Timestamp date,
	IND_Testo varchar(500),
	IND_PER_ITI_Id integer,
	FOREIGN KEY(IND_PER_ITI_Id) references percorre(PER_ITI_Id),
	IND_PER_GRU_Id integer,
	FOREIGN KEY(IND_PER_GRU_Id) references percorre(PER_GRU_Id)
)
	