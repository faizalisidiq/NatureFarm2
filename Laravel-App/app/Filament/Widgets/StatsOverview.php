<?php

namespace App\Filament\Widgets;

use App\Models\Customer;
use App\Models\Hewan;
use App\Models\Pakan;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        $countHewwan = Hewan::count();
        $countPakan = Pakan::count();
        $countCustomer = Customer::count();
        return [
            Stat::make('Jumlah Hewan', $countHewwan)
                ->icon('healthicons-o-animal-cow'),
            Stat::make('Jumlah Pakan', $countPakan)
                ->icon('fluentui-food-grains-24-o'),
            Stat::make('Jumlah Customer', $countCustomer)
                ->icon('icon-customer'),
        ];
    }
}
