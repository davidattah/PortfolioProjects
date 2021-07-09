--Standardze date format

Select SaleDateConverted, Convert(date,SaleDate)
From Project..NashvilleHousing 

Update NashvilleHousing 
Set SaleDate = Convert(Date, SaleDate)

Alter Table NashvilleHousing 
Add SaleDateConverted Date; 

Update NashvilleHousing 
Set SaleDateConverted = Convert(Date, SaleDate)

--Populate Property Address 

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress, b.PropertyAddress)
From Project..NashvilleHousing a
join Project..NashvilleHousing b
	on a.ParcelID = B.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null

Update a 
Set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
From Project..NashvilleHousing a
Join Project..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
where a.propertyAddress is null

--Breaking out Address into Individual Column(Address, City, State)

Select 
Substring(PropertyAddress, 1, Charindex(',',PropertyAddress) -1) as Address,
Substring(PropertyAddress, Charindex(',',PropertyAddress) +1, Len(PropertyAddress)) as Address


Alter Table NashvilleHousing 
Add PropertySplitAddress NvarChar(255);

Update NashvilleHousing 
Set PropertySplitAddress = Substring(PropertyAddress, 1, Charindex(',',PropertyAddress) -1)

Alter Table NashvilleHousing 
Add PropertySplitCity NvarChar(255);

Update NashvilleHousing 
Set PropertySplitCity = Substring(PropertyAddress, Charindex(',',PropertyAddress) +1, Len(PropertyAddress)) 

Select 
Parsename(Replace(OwnerAddress, ',' ,'.'), 3),
Parsename(Replace(OwnerAddress, ',' ,'.'), 2),
Parsename(Replace(OwnerAddress, ',' ,'.'),1)
From Project..NashvilleHousing

Alter Table NashvilleHousing 
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing 
Set OwnerSplitAddress = Parsename(Replace(OwnerAddress, ',','.'),3)


Alter Table NashvilleHousing 
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing 
Set OwnerSplitCity = Parsename(Replace(OwnerAddress, ',' ,'.'), 2)


Alter Table NashvilleHousing 
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing 
Set OwnerSplitState = Parsename(Replace(OwnerAddress, ',','.'), 1)

-- CHANGE Y and N to Yes and No in "Sold as Vacant" field 

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From Project..NashvilleHousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant,
	case when SoldAsVacant = 'Y' then 'Yes'
		 when SoldAsVacant = 'N' then 'No'
		 else SoldAsVacant 
		 end 
from Project..NashvilleHousing


Update NashvilleHousing
Set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
	 when SoldAsVacant = 'N' then 'No'
		 else SoldAsVacant 
		 end 

--Remove Duplicates 

With RowNumCTE AS(
Select *,
	Row_number()over (
	Partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by 
					UniqueID 
					) row_num

From Project..NashvilleHousing 
)

Select * 
From RowNumCTE 
where row_num > 1
Order by PropertyAddress 

--Delete Unused Columns 

Alter Table Project..NashvilleHousing 
Drop column Owneraddress, TaxDistrict, PropertyAddress

Alter Table Project..NashvilleHousing 
Drop column SaleDate

