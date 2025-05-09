<?php

namespace App\Filament\Resources\TransaksiHewanResource\Pages;

use App\Filament\Resources\TransaksiHewanResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListTransaksiHewans extends ListRecords
{
    protected static string $resource = TransaksiHewanResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
