﻿CREATE PROCEDURE [dbo].[CipherDetails_CreateWithCollections]
    @Id UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER,
    @OrganizationId UNIQUEIDENTIFIER,
    @Type TINYINT,
    @Data NVARCHAR(MAX),
    @Favorites NVARCHAR(MAX), -- not used
    @Folders NVARCHAR(MAX), -- not used
    @Attachments NVARCHAR(MAX), -- not used
    @CreationDate DATETIME2(7),
    @RevisionDate DATETIME2(7),
    @FolderId UNIQUEIDENTIFIER,
    @Favorite BIT,
    @Edit BIT, -- not used
    @OrganizationUseTotp BIT, -- not used
    @CollectionIds AS [dbo].[GuidIdArray] READONLY
AS
BEGIN
    SET NOCOUNT ON

    EXEC [dbo].[CipherDetails_Create] @Id, @UserId, @OrganizationId, @Type, @Data, @Favorites, @Folders,
        @Attachments, @CreationDate, @RevisionDate, @FolderId, @Favorite, @Edit, @OrganizationUseTotp

    DECLARE @UpdateCollectionsSuccess INT
    EXEC @UpdateCollectionsSuccess = [dbo].[Cipher_UpdateCollections] @Id, @UserId, @OrganizationId, @CollectionIds
END