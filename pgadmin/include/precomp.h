//////////////////////////////////////////////////////////////////////////
//
// pgAdmin III - PostgreSQL Tools
//
// Copyright (C) 2002 - 2011, The pgAdmin Development Team
// This software is released under the PostgreSQL Licence
//
// precomp.h - All header files for compilers supporting precompiled headers
//
//////////////////////////////////////////////////////////////////////////

#ifdef WX_PRECOMP

#include "copyright.h"
#include "pgAdmin3.h"
#include "version.h"

#include "agent/dlgJob.h"
#include "agent/dlgSchedule.h"
#include "agent/dlgStep.h"
#include "agent/pgaJob.h"
#include "agent/pgaSchedule.h"
#include "agent/pgaStep.h"

#include "ctl/calbox.h"
#include "ctl/ctlAuiNotebook.h"
#include "ctl/ctlCheckTreeView.h"
#include "ctl/ctlColourPicker.h"
#include "ctl/ctlComboBox.h"
#include "ctl/ctlListView.h"
#include "ctl/ctlSecurityPanel.h"
#include "ctl/ctlSQLBox.h"
#include "ctl/ctlSQLGrid.h"
#include "ctl/ctlSQLResult.h"
#include "ctl/ctlTree.h"
#include "ctl/explainCanvas.h"
#include "ctl/timespin.h"
#include "ctl/wxgridsel.h"
#include "ctl/xh_calb.h"
#include "ctl/xh_ctlcombo.h"
#include "ctl/xh_ctlchecktreeview.h"
#include "ctl/xh_ctlcolourpicker.h"
#include "ctl/xh_ctltree.h"
#include "ctl/xh_sqlbox.h"
#include "ctl/xh_timespin.h"

#include "db/pgConn.h"
#include "db/pgQueryThread.h"
#include "db/pgSet.h"

#include "debugger/ctlCodeWindow.h"
#include "debugger/ctlMessageWindow.h"
#include "debugger/ctlResultGrid.h"
#include "debugger/ctlStackWindow.h"
#include "debugger/ctlTabWindow.h"
#include "debugger/ctlVarWindow.h"
#include "debugger/dbgBreakPoint.h"
#include "debugger/dbgConnProp.h"
#include "debugger/dbgConst.h"
#include "debugger/dbgDbResult.h"
#include "debugger/dbgPgConn.h"
#include "debugger/dbgPgThread.h"
#include "debugger/dbgResultset.h"
#include "debugger/dbgTargetInfo.h"
#include "debugger/debugger.h"
#include "debugger/dlgDirectDbg.h"
#include "debugger/frmDebugger.h"

#include "dlg/dlgAddFavourite.h"
#include "dlg/dlgAggregate.h"
#include "dlg/dlgCast.h"
#include "dlg/dlgCheck.h"
#include "dlg/dlgClasses.h"
#include "dlg/dlgColumn.h"
#include "dlg/dlgConnect.h"
#include "dlg/dlgConversion.h"
#include "dlg/dlgDatabase.h"
#include "dlg/dlgDomain.h"
#include "dlg/dlgEditGridOptions.h"
#include "dlg/dlgFindReplace.h"
#include "dlg/dlgForeignKey.h"
#include "dlg/dlgFunction.h"
#include "dlg/dlgGroup.h"
#include "dlg/dlgHbaConfig.h"
#include "dlg/dlgIndex.h"
#include "dlg/dlgIndexConstraint.h"
#include "dlg/dlgLanguage.h"
#include "dlg/dlgMainConfig.h"
#include "dlg/dlgManageFavourites.h"
#include "dlg/dlgManageMacros.h"
#include "dlg/dlgOperator.h"
#include "dlg/dlgPackage.h"
#include "dlg/dlgPgpassConfig.h"
#include "dlg/dlgProperty.h"
#include "dlg/dlgRole.h"
#include "dlg/dlgRule.h"
#include "dlg/dlgSchema.h"
#include "dlg/dlgSelectConnection.h"
#include "dlg/dlgSelectDatabase.h"
#include "dlg/dlgSequence.h"
#include "dlg/dlgServer.h"
#include "dlg/dlgSynonym.h"
#include "dlg/dlgTable.h"
#include "dlg/dlgTablespace.h"
#include "dlg/dlgTextSearchConfiguration.h"
#include "dlg/dlgTextSearchDictionary.h"
#include "dlg/dlgTextSearchTemplate.h"
#include "dlg/dlgTextSearchParser.h"
#include "dlg/dlgTrigger.h"
#include "dlg/dlgType.h"
#include "dlg/dlgUser.h"
#include "dlg/dlgView.h"
#include "dlg/dlgExtTable.h"

#include "frm/frmAbout.h"
#include "frm/frmBackup.h"
#include "frm/frmConfig.h"
#include "frm/frmEditGrid.h"
#include "frm/frmExport.h"
#include "frm/frmGrantWizard.h"
#include "frm/frmHbaConfig.h"
#include "frm/frmHint.h"
#include "frm/frmMain.h"
#include "frm/frmMainConfig.h"
#include "frm/frmMaintenance.h"
#include "frm/frmOptions.h"
#include "frm/frmPassword.h"
#include "frm/frmPgpassConfig.h"
#include "frm/frmQuery.h"
#include "frm/frmReport.h"
#include "frm/frmRestore.h"
#include "frm/frmSplash.h"
#include "frm/frmStatus.h"
#include "frm/menu.h"

#include "gqb/gqbArrayCollection.h"
#include "gqb/gqbBrowser.h"
#include "gqb/gqbCollection.h"
#include "gqb/gqbCollectionBase.h"
#include "gqb/gqbColumn.h"
#include "gqb/gqbDatabase.h"
#include "gqb/gqbEvents.h"
#include "gqb/gqbGraphBehavior.h"
#include "gqb/gqbGraphSimple.h"
#include "gqb/gqbGridOrderTable.h"
#include "gqb/gqbGridProjTable.h"
#include "gqb/gqbGridRestTable.h"
#include "gqb/gqbModel.h"
#include "gqb/gqbObject.h"
#include "gqb/gqbObjectCollection.h"
#include "gqb/gqbQueryObjs.h"
#include "gqb/gqbSchema.h"
#include "gqb/gqbTable.h"
#include "gqb/gqbViewController.h"
#include "gqb/gqbViewPanels.h"

#include "schema/edbPackage.h"
#include "schema/edbPackageFunction.h"
#include "schema/edbPackageVariable.h"
#include "schema/edbSynonym.h"
#include "schema/pgAggregate.h"
#include "schema/pgCast.h"
#include "schema/pgCatalogObject.h"
#include "schema/pgCheck.h"
#include "schema/pgCollection.h"
#include "schema/pgColumn.h"
#include "schema/pgConstraints.h"
#include "schema/pgConversion.h"
#include "schema/pgDatabase.h"
#include "schema/pgDatatype.h"
#include "schema/pgDomain.h"
#include "schema/pgForeignKey.h"
#include "schema/pgFunction.h"
#include "schema/pgGroup.h"
#include "schema/pgIndex.h"
#include "schema/pgIndexConstraint.h"
#include "schema/pgLanguage.h"
#include "schema/pgObject.h"
#include "schema/pgOperator.h"
#include "schema/pgOperatorClass.h"
#include "schema/pgRole.h"
#include "schema/pgRule.h"
#include "schema/pgSchema.h"
#include "schema/pgSequence.h"
#include "schema/pgServer.h"
#include "schema/pgTable.h"
#include "schema/pgTablespace.h"
#include "schema/pgTextSearchConfiguration.h"
#include "schema/pgTextSearchDictionary.h"
#include "schema/pgTextSearchTemplate.h"
#include "schema/pgTextSearchParser.h"
#include "schema/pgTrigger.h"
#include "schema/pgType.h"
#include "schema/pgUser.h"
#include "schema/pgView.h"
#include "schema/gpExtTable.h"
#include "schema/gpPartition.h"
#include "schema/gpResQueue.h"

#include "slony/dlgRepCluster.h"
#include "slony/dlgRepListen.h"
#include "slony/dlgRepNode.h"
#include "slony/dlgRepPath.h"
#include "slony/dlgRepProperty.h"
#include "slony/dlgRepSequence.h"
#include "slony/dlgRepSet.h"
#include "slony/dlgRepSubscription.h"
#include "slony/dlgRepTable.h"
#include "slony/slCluster.h"
#include "slony/slListen.h"
#include "slony/slNode.h"
#include "slony/slPath.h"
#include "slony/slSequence.h"
#include "slony/slSet.h"
#include "slony/slSubscription.h"
#include "slony/slTable.h"

#include "utils/csvfiles.h"
#include "utils/factory.h"
#include "utils/favourites.h"
#include "utils/macros.h"
#include "utils/misc.h"
#include "utils/pgDefs.h"
#include "utils/pgconfig.h"
#include "utils/pgfeatures.h"
#include "utils/sysLogger.h"
#include "utils/sysProcess.h"
#include "utils/sysSettings.h"
#include "utils/utffile.h"

#endif
