<?php

namespace App\Filament\Resources\HewanResource\Pages;

use App\Filament\Resources\HewanResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListHewans extends ListRecords
{
    protected static string $resource = HewanResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
