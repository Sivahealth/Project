import React from 'react'
import { Line } from 'react-chartjs-2';
import './DashBoard.css'

const Newpatient_chart = ({data}) => {
    
    if (!data || !data.labels || !data.values) {
        return <div className='Loading'>Loading... </div> // Or any loading indicator
    }
    
    const chartData = {
        labels: data.labels,
        datasets: [
            {
                label: 'New Patients',
                data: data.values,
                fill: false,
                backgroundColor: 'rgb(75, 192, 192)',
                borderColor: 'rgba(75, 192, 192, 0.2)',
            },
        ],
    };

    return(
        <div className="chart-container">
        <h2 className="chart-title">New Patients</h2>
        <Line data={chartData} />
        </div>
    ) ;
};

export default Newpatient_chart
