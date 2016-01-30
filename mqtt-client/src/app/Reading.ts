class Reading {
    reading_kg: number;
    time: Date;
    avg_since: Date;
    pot_name: string;

    constructor(reading_kg: number, time: Date, avg_since: Date, pot_name: string){
    	this.reading_kg = reading_kg;
    	this.time = time;
    	this.avg_since = avg_since;
    	this.pot_name = pot_name;
    }

}