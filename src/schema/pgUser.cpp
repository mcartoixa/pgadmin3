//////////////////////////////////////////////////////////////////////////
//
// pgAdmin III - PostgreSQL Tools
// Copyright (C) 2002, The pgAdmin Development Team
// This software is released under the pgAdmin Public Licence
//
// pgUser.cpp - PostgreSQL User
//
//////////////////////////////////////////////////////////////////////////

// wxWindows headers
#include <wx/wx.h>

// App headers
#include "pgAdmin3.h"
#include "pgUser.h"
#include "pgObject.h"

pgUser::pgUser(const wxString& szNewName)
: pgObject()
{

    wxLogInfo(wxT("Creating a pgUser object"));

    // Call the 'virtual' ctor
    vCtor(PG_USER, szNewName);
}

pgUser::~pgUser()
{
    wxLogInfo(wxT("Destroying a pgUser object"));
}

int pgUser::GetUserID() {
    return iUserID;
}

// Parent objects
pgServer *pgUser::GetServer() {
    return objServer;
}

void pgUser::SetServer(pgServer *objNewServer) {
    objServer = objNewServer;
}
