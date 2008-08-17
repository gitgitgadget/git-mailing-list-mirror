From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 31/31] Push GUI
Date: Sun, 17 Aug 2008 22:44:12 +0200
Message-ID: <1219005852-21496-32-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-21-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-22-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-23-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-24-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-25-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-26-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-27-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-28-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-29-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-30-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-31-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpAN-0003WL-GV
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbYHQUq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYHQUq0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:46:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27774 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbYHQUqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:46:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489195fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GRMDn48kDmhHZl6R1JC7vqFZTj8L+p5b9eHULMcfmjY=;
        b=DiFpZM2hu1C1t/g7JL//iUb302vKrThr2OW2eET8R1vQDHXifQLJ6LeYw6eFbPi2Mp
         k0CfHTrRxn1dtL8nCYFNAe9/WW0a8jcopBpy+DCjtN9PJXsOuQUZehYdHn/5sRK5/gNJ
         XdgebA0eYLLpSK0REqQDC0y1dx2AwX7NUp2k8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZL87MpyY+y6ayiSo/U9eCDRn/y/JMR/uEz2RFz/EM3KRPG8bpiZN5EF5pgXPvsaK5i
         pgz1zwjl+RLGdt1jyF2LFrZCHqv9FVBo9pCxt4iC4cQS52FUOstjjt+z/96961FVn3eG
         tWeS/ylgv9Bwdh9IvXqmMq+izSPGfzjHpu/Ms=
Received: by 10.86.96.18 with SMTP id t18mr4010134fgb.34.1219005980504;
        Sun, 17 Aug 2008 13:46:20 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 12sm10376224fgg.0.2008.08.17.13.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:46:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-31-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92662>

Push operation in GUI is implemented as wizard consisting of 3 pages:
-repository selection
-ref specifications selection
-confirmation page with dry run results (optional - can be skipped)

Wizard finish-action starts Job with PushOperation. Dialog with results
is shown when job ends. It can be configured to be displayed only if
results change since confirmation.

With confirmation page, it is possible to perform 2-stage push, allowing
user to preview updates and mark them to be performed only if
advertised refs don't change.

Eventually, results Dialog can be replaced with Result/Transport view
some day, as this idea arose recently.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |   15 +
 .../src/org/spearce/egit/ui/UIText.java            |  129 ++++++++
 .../egit/ui/internal/actions/PushAction.java       |   47 +++
 .../egit/ui/internal/push/ConfirmationPage.java    |  211 +++++++++++++
 .../egit/ui/internal/push/PushResultTable.java     |  327 ++++++++++++++++++++
 .../spearce/egit/ui/internal/push/PushWizard.java  |  250 +++++++++++++++
 .../ui/internal/push/RefUpdateContentProvider.java |   62 ++++
 .../egit/ui/internal/push/RefUpdateElement.java    |   67 ++++
 .../egit/ui/internal/push/ResultDialog.java        |   65 ++++
 .../src/org/spearce/egit/ui/uitext.properties      |   47 +++
 11 files changed, 1223 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateElement.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index ce3b058..8ac3474 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -41,6 +41,9 @@ ResetAction_tooltip=Reset the current branch to the same or another commit
 BranchAction_label=&Branch...
 BranchAction_tooltip=Switch to another branch
 
+PushAction_label=&Push To...
+PushAction_tooltip=Push to another repository
+
 GitActions_label=Git
 GitMenu_label=&Git
 
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 0b59a6e..ca93f5a 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -40,6 +40,12 @@
                id="org.spearce.egit.ui.internal.actions.Disconnect">
          </action>
          <action
+               class="org.spearce.egit.ui.internal.actions.PushAction"
+               id="org.spearce.egit.ui.internal.actions.PushAction"
+               label="%PushAction_label"
+               menubarPath="team.main/projectGroup"
+               tooltip="%PushAction_tooltip"/>         
+         <action
                class="org.spearce.egit.ui.internal.actions.ResetAction"
                id="org.spearce.egit.ui.internal.actions.ResetAction"
                label="%ResetAction_label"
@@ -253,6 +259,15 @@
         </separator>
 	    </menu>
 		<action
+		       class="org.spearce.egit.ui.internal.actions.PushAction"
+		       id="org.spearce.egit.ui.actionpush"
+		       label="%PushAction_label"
+		       style="push"
+		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
+		       toolbarPath="org.spearce.egit.ui"
+		       tooltip="%PushAction_tooltip">
+		</action>
+		<action
 		       class="org.spearce.egit.ui.internal.actions.BranchAction"
 		       disabledIcon="icons/toolbar/checkoutd.png"
 		       icon="icons/toolbar/checkoute.png"
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index ff2b541..cc785f7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -464,6 +464,135 @@ public class UIText extends NLS {
 	public static String HistoryPreferencePage_title;
 
 	/** */
+	public static String PushWizard_cantConnectToAny;
+
+	/** */
+	public static String PushWizard_cantPrepareUpdatesMessage;
+
+	/** */
+	public static String PushWizard_cantPrepareUpdatesTitle;
+
+	/** */
+	public static String PushWizard_cantSaveMessage;
+
+	/** */
+	public static String PushWizard_cantSaveTitle;
+
+	/** */
+	public static String PushWizard_jobName;
+
+	/** */
+	public static String PushWizard_missingRefsMessage;
+
+	/** */
+	public static String PushWizard_missingRefsTitle;
+
+	/** */
+	public static String PushWizard_unexpectedError;
+
+	/** */
+	public static String PushWizard_windowTitleDefault;
+
+	/** */
+	public static String PushWizard_windowTitleWithDestination;
+
+	/** */
+	public static String ConfirmationPage_cantConnectToAny;
+
+	/** */
+	public static String ConfirmationPage_description;
+
+	/** */
+	public static String ConfirmationPage_errorCantResolveSpecs;
+
+	/** */
+	public static String ConfirmationPage_errorInterrupted;
+
+	/** */
+	public static String ConfirmationPage_errorRefsChangedNoMatch;
+
+	/** */
+	public static String ConfirmationPage_errorUnexpected;
+
+	/** */
+	public static String ConfirmationPage_requireUnchangedButton;
+
+	/** */
+	public static String ConfirmationPage_showOnlyIfChanged;
+
+	/** */
+	public static String ConfirmationPage_title;
+
+	/** */
+	public static String PushResultTable_columnStatusRepo;
+
+	/** */
+	public static String PushResultTable_columnDst;
+
+	/** */
+	public static String PushResultTable_columnSrc;
+
+	/** */
+	public static String PushResultTable_columnMode;
+
+	/** */
+	public static String PushResultTable_statusUnexpected;
+
+	/** */
+	public static String PushResultTable_statusConnectionFailed;
+
+	/** */
+	public static String PushResultTable_statusDetailChanged;
+
+	/** */
+	public static String PushResultTable_refNonExisting;
+
+	/** */
+	public static String PushResultTable_statusDetailDeleted;
+
+	/** */
+	public static String PushResultTable_statusDetailNonFastForward;
+
+	/** */
+	public static String PushResultTable_statusDetailNoDelete;
+
+	/** */
+	public static String PushResultTable_statusDetailNonExisting;
+
+	/** */
+	public static String PushResultTable_statusDetailForcedUpdate;
+
+	/** */
+	public static String PushResultTable_statusDetailFastForward;
+
+	/** */
+	public static String PushResultTable_statusRemoteRejected;
+
+	/** */
+	public static String PushResultTable_statusRejected;
+
+	/** */
+	public static String PushResultTable_statusNoMatch;
+
+	/** */
+	public static String PushResultTable_statusUpToDate;
+
+	/** */
+	public static String PushResultTable_statusOkDeleted;
+
+	/** */
+	public static String PushResultTable_statusOkNewBranch;
+
+	/** */
+	public static String PushResultTable_statusOkNewTag;
+
+	/** */
+	public static String ResultDialog_title;
+
+	/** */
+	public static String ResultDialog_label;
+
+	/** */
 	public static String WindowCachePreferencePage_title;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java
new file mode 100644
index 0000000..61833d0
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/PushAction.java
@@ -0,0 +1,47 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import java.net.URISyntaxException;
+
+import org.eclipse.jface.action.IAction;
+import org.eclipse.jface.dialogs.MessageDialog;
+import org.eclipse.jface.wizard.WizardDialog;
+import org.spearce.egit.ui.internal.push.PushWizard;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * Action for choosing specifications for push, and pushing out to another
+ * repository.
+ */
+public class PushAction extends RepositoryAction {
+
+	@Override
+	public void run(IAction action) {
+		final Repository repository = getRepository(true);
+		if (repository == null)
+			return;
+
+		final PushWizard pushWizard;
+		try {
+			pushWizard = new PushWizard(repository);
+		} catch (URISyntaxException x) {
+			MessageDialog.openError(getShell(), "Corrupted configuration",
+					"Remote repositories URLs configuration is corrupted: "
+							+ x.getMessage());
+			return;
+		}
+		final WizardDialog dialog = new WizardDialog(getShell(), pushWizard);
+		dialog.open();
+	}
+
+	@Override
+	public boolean isEnabled() {
+		return getRepository(false) != null;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
new file mode 100644
index 0000000..38109d2
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
@@ -0,0 +1,211 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.push;
+
+import java.io.IOException;
+import java.lang.reflect.InvocationTargetException;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.List;
+
+import org.eclipse.jface.wizard.WizardPage;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.spearce.egit.core.op.PushOperation;
+import org.spearce.egit.core.op.PushOperationResult;
+import org.spearce.egit.core.op.PushOperationSpecification;
+import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.components.RefSpecPage;
+import org.spearce.egit.ui.internal.components.RepositorySelection;
+import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
+import org.spearce.egit.ui.internal.components.SelectionChangeListener;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
+
+class ConfirmationPage extends WizardPage {
+	static Collection<RemoteRefUpdate> copyUpdates(
+			final Collection<RemoteRefUpdate> refUpdates) throws IOException {
+		final Collection<RemoteRefUpdate> copy = new ArrayList<RemoteRefUpdate>(
+				refUpdates.size());
+		for (final RemoteRefUpdate rru : refUpdates)
+			copy.add(new RemoteRefUpdate(rru, null));
+		return copy;
+	}
+
+	private final Repository local;
+
+	private final RepositorySelectionPage repoPage;
+
+	private final RefSpecPage refSpecPage;
+
+	private RepositorySelection displayedRepoSelection;
+
+	private List<RefSpec> displayedRefSpecs;
+
+	private PushOperationResult confirmedResult;
+
+	private PushResultTable resultPanel;
+
+	private Button requireUnchangedButton;
+
+	private Button showOnlyIfChanged;
+
+	public ConfirmationPage(final Repository local,
+			final RepositorySelectionPage repoPage,
+			final RefSpecPage refSpecPage) {
+		super(ConfirmationPage.class.getName());
+		this.local = local;
+		this.repoPage = repoPage;
+		this.refSpecPage = refSpecPage;
+
+		setTitle(UIText.ConfirmationPage_title);
+		setDescription(UIText.ConfirmationPage_description);
+
+		final SelectionChangeListener listener = new SelectionChangeListener() {
+			public void selectionChanged() {
+				checkPreviousPagesSelections();
+			}
+		};
+		repoPage.addSelectionListener(listener);
+		refSpecPage.addSelectionListener(listener);
+	}
+
+	public void createControl(final Composite parent) {
+		final Composite panel = new Composite(parent, SWT.NONE);
+		panel.setLayout(new GridLayout());
+
+		resultPanel = new PushResultTable(panel);
+		final Control tableControl = resultPanel.getControl();
+		tableControl
+				.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true));
+
+		requireUnchangedButton = new Button(panel, SWT.CHECK);
+		requireUnchangedButton
+				.setText(UIText.ConfirmationPage_requireUnchangedButton);
+
+		showOnlyIfChanged = new Button(panel, SWT.CHECK);
+		showOnlyIfChanged.setText(UIText.ConfirmationPage_showOnlyIfChanged);
+
+		setControl(panel);
+	}
+
+	@Override
+	public void setVisible(final boolean visible) {
+		if (visible)
+			revalidate();
+		super.setVisible(visible);
+	}
+
+	boolean isConfirmed() {
+		return confirmedResult != null;
+	}
+
+	PushOperationResult getConfirmedResult() {
+		return confirmedResult;
+	}
+
+	boolean isRequireUnchangedSelected() {
+		return requireUnchangedButton.getSelection();
+	}
+
+	boolean isShowOnlyIfChangedSelected() {
+		return showOnlyIfChanged.getSelection();
+	}
+
+	private void checkPreviousPagesSelections() {
+		if (!repoPage.selectionEquals(displayedRepoSelection)
+				|| !refSpecPage.specsSelectionEquals(displayedRefSpecs)) {
+			// Allow user to finish by skipping confirmation...
+			setPageComplete(true);
+		} else {
+			// ... but if user doesn't skip confirmation, allow only when no
+			// critical errors occurred
+			setPageComplete(confirmedResult != null);
+		}
+	}
+
+	private void revalidate() {
+		// always update this page
+		resultPanel.setData(local, new PushOperationResult());
+		confirmedResult = null;
+		displayedRepoSelection = repoPage.getSelection();
+		displayedRefSpecs = refSpecPage.getRefSpecs();
+		setErrorMessage(null);
+		setPageComplete(false);
+		getControl().getDisplay().asyncExec(new Runnable() {
+			public void run() {
+				revalidateImpl();
+			}
+		});
+	}
+
+	private void revalidateImpl() {
+		if (getControl().isDisposed() || !isCurrentPage())
+			return;
+		
+		final List<RefSpec> fetchSpecs;
+		if (displayedRepoSelection.isConfigSelected())
+			fetchSpecs = displayedRepoSelection.getConfig().getFetchRefSpecs();
+		else
+			fetchSpecs = null;
+
+		final PushOperation operation;
+		try {
+			final Collection<RemoteRefUpdate> updates = Transport
+					.findRemoteRefUpdatesFor(local, displayedRefSpecs,
+							fetchSpecs);
+			if (updates.isEmpty()) {
+				// It can happen only when local refs changed in the mean time.
+				setErrorMessage(UIText.ConfirmationPage_errorRefsChangedNoMatch);
+				setPageComplete(false);
+				return;
+			}
+
+			final PushOperationSpecification spec = new PushOperationSpecification();
+			for (final URIish uri : displayedRepoSelection.getAllURIs())
+				spec.addURIRefUpdates(uri, copyUpdates(updates));
+
+			operation = new PushOperation(local, spec, true,
+					displayedRepoSelection.getConfig());
+			getContainer().run(true, true, operation);
+		} catch (final IOException e) {
+			setErrorMessage(NLS.bind(
+					UIText.ConfirmationPage_errorCantResolveSpecs, e
+							.getMessage()));
+			return;
+		} catch (final InvocationTargetException e) {
+			setErrorMessage(NLS.bind(UIText.ConfirmationPage_errorUnexpected, e
+					.getCause().getMessage()));
+			return;
+		} catch (final InterruptedException e) {
+			setErrorMessage(UIText.ConfirmationPage_errorInterrupted);
+			setPageComplete(true);
+			displayedRefSpecs = null;
+			displayedRepoSelection = null;
+			return;
+		}
+
+		final PushOperationResult result = operation.getOperationResult();
+		resultPanel.setData(local, result);
+		if (result.isSuccessfulConnectionForAnyURI()) {
+			setPageComplete(true);
+			confirmedResult = result;
+		} else {
+			setErrorMessage(NLS.bind(UIText.ConfirmationPage_cantConnectToAny,
+					result.getErrorStringForAllURis()));
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
new file mode 100644
index 0000000..5daf153
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
@@ -0,0 +1,327 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.push;
+
+import org.eclipse.jface.layout.TableColumnLayout;
+import org.eclipse.jface.resource.ColorRegistry;
+import org.eclipse.jface.resource.ImageRegistry;
+import org.eclipse.jface.viewers.ColumnLabelProvider;
+import org.eclipse.jface.viewers.ColumnViewerToolTipSupport;
+import org.eclipse.jface.viewers.ColumnWeightData;
+import org.eclipse.jface.viewers.IElementComparer;
+import org.eclipse.jface.viewers.TableViewer;
+import org.eclipse.jface.viewers.TableViewerColumn;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.DisposeEvent;
+import org.eclipse.swt.events.DisposeListener;
+import org.eclipse.swt.graphics.Color;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.graphics.RGB;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Table;
+import org.eclipse.swt.widgets.TableColumn;
+import org.spearce.egit.core.op.PushOperationResult;
+import org.spearce.egit.ui.UIIcons;
+import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.components.CenteredImageLabelProvider;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.URIish;
+import org.spearce.jgit.transport.RemoteRefUpdate.Status;
+
+/**
+ * Table displaying push operation results.
+ */
+class PushResultTable {
+	private static final int TABLE_PREFERRED_WIDTH = 650;
+
+	private static final int TABLE_PREFERRED_HEIGHT = 300;
+
+	private static final int COLUMN_STATUS_WEIGHT = 40;
+
+	private static final int COLUMN_DST_WEIGHT = 40;
+
+	private static final int COLUMN_SRC_WEIGHT = 40;
+
+	private static final int COLUMN_MODE_WEIGHT = 15;
+
+	private static final String IMAGE_DELETE = "MODE_DELETE";
+
+	private static final String IMAGE_ADD = "MODE_ADD";
+
+	private static final String COLOR_REJECTED_KEY = "REJECTED";
+
+	private static final RGB COLOR_REJECTED = new RGB(255, 0, 0);
+
+	private static final String COLOR_UPDATED_KEY = "UPDATED";
+
+	private static final RGB COLOR_UPDATED = new RGB(0, 255, 0);
+
+	private static final String COLOR_UP_TO_DATE_KEY = "UP_TO_DATE";
+
+	private static final RGB COLOR_UP_TO_DATE = new RGB(245, 245, 245);
+
+	private final TableViewer tableViewer;
+
+	private final Composite tablePanel;
+
+	private final ImageRegistry imageRegistry;
+
+	private final ColorRegistry colorRegistry;
+
+	PushResultTable(final Composite parent) {
+		tablePanel = new Composite(parent, SWT.NONE);
+		tablePanel.setLayout(new GridLayout());
+		final GridData layoutData = new GridData(SWT.FILL, SWT.FILL, true, true);
+		layoutData.heightHint = TABLE_PREFERRED_HEIGHT;
+		layoutData.widthHint = TABLE_PREFERRED_WIDTH;
+		tableViewer = new TableViewer(tablePanel);
+		ColumnViewerToolTipSupport.enableFor(tableViewer);
+		final Table table = tableViewer.getTable();
+		table.setLinesVisible(true);
+		table.setHeaderVisible(true);
+
+		imageRegistry = new ImageRegistry(table.getDisplay());
+		imageRegistry.put(IMAGE_ADD, UIIcons.ELCL16_ADD);
+		imageRegistry.put(IMAGE_DELETE, UIIcons.ELCL16_DELETE);
+
+		colorRegistry = new ColorRegistry(table.getDisplay());
+		colorRegistry.put(COLOR_REJECTED_KEY, COLOR_REJECTED);
+		colorRegistry.put(COLOR_UPDATED_KEY, COLOR_UPDATED);
+		colorRegistry.put(COLOR_UP_TO_DATE_KEY, COLOR_UP_TO_DATE);
+
+		tablePanel.addDisposeListener(new DisposeListener() {
+			public void widgetDisposed(DisposeEvent e) {
+				imageRegistry.dispose();
+			}
+		});
+
+		tableViewer.setComparer(new IElementComparer() {
+			// we need this to keep refresh() working while having custom
+			// equals() in PushOperationResult
+			public boolean equals(Object a, Object b) {
+				return a == b;
+			}
+
+			public int hashCode(Object element) {
+				return element.hashCode();
+			}
+		});
+		tableViewer.setContentProvider(new RefUpdateContentProvider());
+		tableViewer.setInput(new PushOperationResult());
+	}
+
+	void setData(final Repository localDb, final PushOperationResult result) {
+		// We have to recreate columns.
+		for (final TableColumn tc : tableViewer.getTable().getColumns())
+			tc.dispose();
+		// Set empty result for a while.
+		tableViewer.setInput(new PushOperationResult());
+
+		// Layout should be recreated to work properly.
+		final TableColumnLayout layout = new TableColumnLayout();
+		tablePanel.setLayout(layout);
+
+		final TableViewerColumn modeViewer = createColumn(layout,
+				UIText.PushResultTable_columnMode, COLUMN_MODE_WEIGHT,
+				SWT.CENTER);
+		modeViewer.setLabelProvider(new CenteredImageLabelProvider() {
+			@Override
+			public Image getImage(Object element) {
+				if (((RefUpdateElement) element).isDelete())
+					return imageRegistry.get(IMAGE_DELETE);
+				return imageRegistry.get(IMAGE_ADD);
+			}
+
+			@Override
+			public String getToolTipText(Object element) {
+				if (((RefUpdateElement) element).isDelete())
+					return UIText.RefSpecPanel_modeDeleteDescription;
+				return UIText.RefSpecPanel_modeUpdateDescription;
+			}
+		});
+
+		final TableViewerColumn srcViewer = createColumn(layout,
+				UIText.PushResultTable_columnSrc, COLUMN_SRC_WEIGHT, SWT.LEFT);
+		srcViewer.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(Object element) {
+				return ((RefUpdateElement) element).getSrcRefName();
+			}
+		});
+
+		final TableViewerColumn dstViewer = createColumn(layout,
+				UIText.PushResultTable_columnDst, COLUMN_DST_WEIGHT, SWT.LEFT);
+		dstViewer.setLabelProvider(new ColumnLabelProvider() {
+			@Override
+			public String getText(Object element) {
+				return ((RefUpdateElement) element).getDstRefName();
+			}
+		});
+
+		int i = 0;
+		for (final URIish uri : result.getURIs()) {
+			final TableViewerColumn statusViewer = createColumn(layout, NLS
+					.bind(UIText.PushResultTable_columnStatusRepo, Integer
+							.toString(++i)), COLUMN_STATUS_WEIGHT, SWT.CENTER);
+			statusViewer.getColumn().setToolTipText(uri.toString());
+			statusViewer.setLabelProvider(new UpdateStatusLabelProvider(
+					localDb, uri));
+		}
+		tableViewer.setInput(result);
+		tablePanel.layout();
+	}
+
+	Control getControl() {
+		return tablePanel;
+	}
+
+	private TableViewerColumn createColumn(
+			final TableColumnLayout columnLayout, final String text,
+			final int weight, final int style) {
+		final TableViewerColumn viewerColumn = new TableViewerColumn(
+				tableViewer, style);
+		final TableColumn column = viewerColumn.getColumn();
+		column.setText(text);
+		columnLayout.setColumnData(column, new ColumnWeightData(weight));
+		return viewerColumn;
+	}
+
+	private class UpdateStatusLabelProvider extends ColumnLabelProvider {
+		private Repository localDb;
+
+		private final URIish uri;
+
+		UpdateStatusLabelProvider(final Repository localDb, final URIish uri) {
+			this.localDb = localDb;
+			this.uri = uri;
+		}
+
+		@Override
+		public String getText(Object element) {
+			final RefUpdateElement rue = (RefUpdateElement) element;
+			if (!rue.isSuccessfulConnection(uri))
+				return UIText.PushResultTable_statusConnectionFailed;
+
+			final RemoteRefUpdate rru = rue.getRemoteRefUpdate(uri);
+			switch (rru.getStatus()) {
+			case OK:
+				if (rru.isDelete())
+					return UIText.PushResultTable_statusOkDeleted;
+
+				final Ref oldRef = rue.getAdvertisedRemoteRef(uri);
+				if (oldRef == null) {
+					if (rue.getDstRefName().startsWith(
+							Constants.TAGS_PREFIX + "/"))
+						return UIText.PushResultTable_statusOkNewTag;
+					return UIText.PushResultTable_statusOkNewBranch;
+				}
+
+				return oldRef.getObjectId().abbreviate(localDb)
+						+ (rru.isFastForward() ? ".." : "...")
+						+ rru.getNewObjectId().abbreviate(localDb);
+			case UP_TO_DATE:
+				return UIText.PushResultTable_statusUpToDate;
+			case NON_EXISTING:
+				return UIText.PushResultTable_statusNoMatch;
+			case REJECTED_NODELETE:
+			case REJECTED_NONFASTFORWARD:
+			case REJECTED_REMOTE_CHANGED:
+				return UIText.PushResultTable_statusRejected;
+			case REJECTED_OTHER_REASON:
+				return UIText.PushResultTable_statusRemoteRejected;
+			default:
+				throw new IllegalArgumentException(NLS.bind(
+						UIText.PushResultTable_statusUnexpected, rru
+								.getStatus()));
+			}
+		}
+
+		@Override
+		public Color getBackground(Object element) {
+			final RefUpdateElement rue = (RefUpdateElement) element;
+			if (!rue.isSuccessfulConnection(uri))
+				return colorRegistry.get(COLOR_REJECTED_KEY);
+
+			final Status status = rue.getRemoteRefUpdate(uri).getStatus();
+			switch (status) {
+			case OK:
+				return colorRegistry.get(COLOR_UPDATED_KEY);
+			case UP_TO_DATE:
+			case NON_EXISTING:
+				return colorRegistry.get(COLOR_UP_TO_DATE_KEY);
+			case REJECTED_NODELETE:
+			case REJECTED_NONFASTFORWARD:
+			case REJECTED_REMOTE_CHANGED:
+			case REJECTED_OTHER_REASON:
+				return colorRegistry.get(COLOR_REJECTED_KEY);
+			default:
+				throw new IllegalArgumentException(NLS.bind(
+						UIText.PushResultTable_statusUnexpected, status));
+			}
+		}
+
+		@Override
+		public String getToolTipText(Object element) {
+			final RefUpdateElement rue = (RefUpdateElement) element;
+			if (!rue.isSuccessfulConnection(uri))
+				return rue.getErrorMessage(uri);
+
+			final RemoteRefUpdate rru = rue.getRemoteRefUpdate(uri);
+			final Ref oldRef = rue.getAdvertisedRemoteRef(uri);
+			switch (rru.getStatus()) {
+			case OK:
+				if (rru.isDelete())
+					return NLS.bind(UIText.PushResultTable_statusDetailDeleted,
+							oldRef.getObjectId().abbreviate(localDb));
+				if (oldRef == null)
+					return null;
+				if (rru.isFastForward())
+					return UIText.PushResultTable_statusDetailFastForward;
+				return UIText.PushResultTable_statusDetailForcedUpdate;
+			case UP_TO_DATE:
+				return null;
+			case NON_EXISTING:
+				return UIText.PushResultTable_statusDetailNonExisting;
+			case REJECTED_NODELETE:
+				return UIText.PushResultTable_statusDetailNoDelete;
+			case REJECTED_NONFASTFORWARD:
+				return UIText.PushResultTable_statusDetailNonFastForward;
+			case REJECTED_REMOTE_CHANGED:
+				final Ref remoteRef = oldRef;
+				final String currentValue;
+				if (remoteRef == null)
+					currentValue = UIText.PushResultTable_refNonExisting;
+				else
+					currentValue = remoteRef.getObjectId().abbreviate(localDb);
+				final ObjectId expectedOldObjectId = rru
+						.getExpectedOldObjectId();
+				final String expectedValue;
+				if (expectedOldObjectId.equals(ObjectId.zeroId()))
+					expectedValue = UIText.PushResultTable_refNonExisting;
+				else
+					expectedValue = expectedOldObjectId.abbreviate(localDb);
+				return NLS.bind(UIText.PushResultTable_statusDetailChanged,
+						currentValue, expectedValue);
+			case REJECTED_OTHER_REASON:
+				return rru.getMessage();
+			default:
+				throw new IllegalArgumentException(NLS.bind(
+						UIText.PushResultTable_statusUnexpected, rru
+								.getStatus()));
+			}
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java
new file mode 100644
index 0000000..44060df
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java
@@ -0,0 +1,250 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.push;
+
+import java.io.IOException;
+import java.lang.reflect.InvocationTargetException;
+import java.net.URISyntaxException;
+import java.util.Collection;
+import java.util.List;
+
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.jobs.Job;
+import org.eclipse.jface.dialogs.Dialog;
+import org.eclipse.jface.dialogs.ErrorDialog;
+import org.eclipse.jface.wizard.IWizardPage;
+import org.eclipse.jface.wizard.Wizard;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.widgets.Shell;
+import org.eclipse.ui.PlatformUI;
+import org.spearce.egit.core.op.PushOperation;
+import org.spearce.egit.core.op.PushOperationResult;
+import org.spearce.egit.core.op.PushOperationSpecification;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIIcons;
+import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.components.RefSpecPage;
+import org.spearce.egit.ui.internal.components.RepositorySelection;
+import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryConfig;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.transport.RemoteConfig;
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Wizard allowing user to specify all needed data to push to another repository
+ * - including selection of remote repository and refs specifications.
+ * <p>
+ * Push operation is performed upon successful completion of this wizard.
+ */
+public class PushWizard extends Wizard {
+	private static String getURIsString(final Collection<URIish> uris) {
+		final StringBuilder sb = new StringBuilder();
+		boolean first = true;
+		for (final URIish uri : uris) {
+			if (first)
+				first = false;
+			else
+				sb.append(", "); //$NON-NLS-1$
+			sb.append(uri);
+		}
+		return sb.toString();
+	}
+
+	private Repository localDb;
+
+	private final RepositorySelectionPage repoPage;
+
+	private final RefSpecPage refSpecPage;
+
+	private ConfirmationPage confirmPage;
+
+	/**
+	 * Create push wizard for specified local repository.
+	 * 
+	 * @param localDb
+	 *            repository to push from.
+	 * @throws URISyntaxException
+	 *             when configuration of this repository contains illegal URIs.
+	 */
+	public PushWizard(final Repository localDb) throws URISyntaxException {
+		this.localDb = localDb;
+		final List<RemoteConfig> remotes = RemoteConfig
+				.getAllRemoteConfigs(localDb.getConfig());
+		repoPage = new RepositorySelectionPage(false, remotes);
+		refSpecPage = new RefSpecPage(localDb, true, repoPage);
+		confirmPage = new ConfirmationPage(localDb, repoPage, refSpecPage);
+		// TODO use/create another cool icon
+		setDefaultPageImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
+		setNeedsProgressMonitor(true);
+	}
+
+	@Override
+	public void addPages() {
+		addPage(repoPage);
+		addPage(refSpecPage);
+		addPage(confirmPage);
+	}
+
+	@Override
+	public boolean performFinish() {
+		if (repoPage.getSelection().isConfigSelected()
+				&& refSpecPage.isSaveRequested()) {
+			saveRefSpecs();
+		}
+
+		final PushOperation operation = createPushOperation();
+		if (operation == null)
+			return false;
+		final PushOperationResult resultToCompare;
+		if (confirmPage.isShowOnlyIfChangedSelected())
+			resultToCompare = confirmPage.getConfirmedResult();
+		else
+			resultToCompare = null;
+		final Job job = new PushJob(operation, resultToCompare,
+				getDestinationString());
+
+		job.setUser(true);
+		job.schedule();
+
+		return true;
+	}
+
+	@Override
+	public String getWindowTitle() {
+		final IWizardPage currentPage = getContainer().getCurrentPage();
+		if (currentPage == repoPage || currentPage == null)
+			return UIText.PushWizard_windowTitleDefault;
+		final String destination = getDestinationString();
+		return NLS.bind(UIText.PushWizard_windowTitleWithDestination,
+				destination);
+	}
+
+	private void saveRefSpecs() {
+		final RemoteConfig rc = repoPage.getSelection().getConfig();
+		rc.setPushRefSpecs(refSpecPage.getRefSpecs());
+		final RepositoryConfig config = localDb.getConfig();
+		rc.update(config);
+		try {
+			config.save();
+		} catch (final IOException e) {
+			ErrorDialog.openError(getShell(), UIText.PushWizard_cantSaveTitle,
+					UIText.PushWizard_cantSaveMessage, new Status(
+							IStatus.WARNING, Activator.getPluginId(), e
+									.getMessage(), e));
+			// Continue, it's not critical.
+		}
+	}
+
+	private PushOperation createPushOperation() {
+		try {
+			final PushOperationSpecification spec;
+			final RemoteConfig config = repoPage.getSelection().getConfig();
+			if (confirmPage.isConfirmed()) {
+				final PushOperationResult confirmedResult = confirmPage
+						.getConfirmedResult();
+				spec = confirmedResult.deriveSpecification(confirmPage
+						.isRequireUnchangedSelected());
+			} else {
+				final Collection<RefSpec> fetchSpecs;
+				if (config != null)
+					fetchSpecs = config.getFetchRefSpecs();
+				else
+					fetchSpecs = null;
+
+				final Collection<RemoteRefUpdate> updates = Transport
+						.findRemoteRefUpdatesFor(localDb, refSpecPage
+								.getRefSpecs(), fetchSpecs);
+				if (updates.isEmpty()) {
+					ErrorDialog.openError(getShell(),
+							UIText.PushWizard_missingRefsTitle, null,
+							new Status(IStatus.ERROR, Activator.getPluginId(),
+									UIText.PushWizard_missingRefsMessage));
+					return null;
+				}
+
+				spec = new PushOperationSpecification();
+				for (final URIish uri : repoPage.getSelection().getAllURIs())
+					spec.addURIRefUpdates(uri, ConfirmationPage
+							.copyUpdates(updates));
+			}
+			return new PushOperation(localDb, spec, false, config);
+		} catch (final IOException e) {
+			ErrorDialog.openError(getShell(),
+					UIText.PushWizard_cantPrepareUpdatesTitle,
+					UIText.PushWizard_cantPrepareUpdatesMessage, new Status(
+							IStatus.ERROR, Activator.getPluginId(), e
+									.getMessage(), e));
+			return null;
+		}
+	}
+
+	private String getDestinationString() {
+		final RepositorySelection repoSelection = repoPage.getSelection();
+		final String destination;
+		if (repoSelection.isConfigSelected())
+			destination = repoSelection.getConfigName();
+		else
+			destination = repoSelection.getURI().toString();
+		return destination;
+	}
+
+	private class PushJob extends Job {
+		private final PushOperation operation;
+
+		private final PushOperationResult resultToCompare;
+
+		private final String destinationString;
+
+		public PushJob(final PushOperation operation,
+				final PushOperationResult resultToCompare,
+				final String destinationString) {
+			super(NLS.bind(UIText.PushWizard_jobName, getURIsString(operation
+					.getSpecification().getURIs())));
+			this.operation = operation;
+			this.resultToCompare = resultToCompare;
+			this.destinationString = destinationString;
+		}
+
+		@Override
+		protected IStatus run(final IProgressMonitor monitor) {
+			try {
+				operation.run(monitor);
+			} catch (final InvocationTargetException e) {
+				return new Status(IStatus.ERROR, Activator.getPluginId(),
+						UIText.PushWizard_unexpectedError, e.getCause());
+			}
+
+			final PushOperationResult result = operation.getOperationResult();
+			if (!result.isSuccessfulConnectionForAnyURI()) {
+				return new Status(IStatus.ERROR, Activator.getPluginId(), NLS
+						.bind(UIText.PushWizard_cantConnectToAny, result
+								.getErrorStringForAllURis()));
+			}
+
+			if (resultToCompare == null || !result.equals(resultToCompare)) {
+				PlatformUI.getWorkbench().getDisplay().asyncExec(
+						new Runnable() {
+							public void run() {
+								final Shell shell = PlatformUI.getWorkbench()
+										.getActiveWorkbenchWindow().getShell();
+								final Dialog dialog = new ResultDialog(shell,
+										localDb, result, destinationString);
+								dialog.open();
+							}
+						});
+			}
+			return Status.OK_STATUS;
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java
new file mode 100644
index 0000000..ccc5340
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java
@@ -0,0 +1,62 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.push;
+
+import java.util.SortedMap;
+import java.util.TreeMap;
+import java.util.Map.Entry;
+
+import org.eclipse.jface.viewers.IStructuredContentProvider;
+import org.eclipse.jface.viewers.Viewer;
+import org.spearce.egit.core.op.PushOperationResult;
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Content provided for push result table viewer.
+ * <p>
+ * Input of this provided must be {@link PushOperationResult} instance, while
+ * returned elements are instances of {@link RefUpdateElement}.
+ * 
+ * @see PushOperationResult
+ * @see RefUpdateElement
+ */
+class RefUpdateContentProvider implements IStructuredContentProvider {
+	public Object[] getElements(final Object inputElement) {
+		final PushOperationResult result = (PushOperationResult) inputElement;
+
+		final SortedMap<String, String> dstToSrc = new TreeMap<String, String>();
+		for (final URIish uri : result.getURIs()) {
+			if (result.isSuccessfulConnection(uri)) {
+				for (final RemoteRefUpdate rru : result.getPushResult(uri)
+						.getRemoteUpdates())
+					dstToSrc.put(rru.getRemoteName(), rru.getSrcRef());
+				// Assuming that each repository received the same ref updates,
+				// we need only one to get these ref names.
+				break;
+			}
+		}
+
+		// Transforming PushOperationResult model to row-wise one.
+		final RefUpdateElement elements[] = new RefUpdateElement[dstToSrc
+				.size()];
+		int i = 0;
+		for (final Entry<String, String> entry : dstToSrc.entrySet())
+			elements[i++] = new RefUpdateElement(result, entry.getValue(),
+					entry.getKey());
+		return elements;
+	}
+
+	public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
+		// nothing to do
+	}
+
+	public void dispose() {
+		// nothing to dispose
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateElement.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateElement.java
new file mode 100644
index 0000000..7b9bce0
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateElement.java
@@ -0,0 +1,67 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.push;
+
+import org.spearce.egit.core.op.PushOperationResult;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.transport.RemoteRefUpdate;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Data class representing row (element) of table with push results.
+ * <p>
+ * Each row is associated with one ref update, while each column is associated
+ * with one URI (remote repository).
+ * 
+ * @see PushOperationResult
+ * @see RefUpdateContentProvider
+ */
+class RefUpdateElement {
+	private final String srcRefName;
+
+	private final String dstRefName;
+
+	private final PushOperationResult result;
+
+	RefUpdateElement(final PushOperationResult result, final String srcRef,
+			final String dstRef) {
+		this.result = result;
+		this.srcRefName = srcRef;
+		this.dstRefName = dstRef;
+	}
+
+	String getSrcRefName() {
+		return srcRefName;
+	}
+
+	String getDstRefName() {
+		return dstRefName;
+	}
+
+	boolean isDelete() {
+		// Assuming that we never use ObjectId.zeroId() in GUI.
+		// (no need to compare to it).
+		return srcRefName == null;
+	}
+	
+	boolean isSuccessfulConnection(final URIish uri) {
+		return result.isSuccessfulConnection(uri);
+	}
+
+	String getErrorMessage(final URIish uri) {
+		return result.getErrorMessage(uri);
+	}
+
+	RemoteRefUpdate getRemoteRefUpdate(final URIish uri) {
+		return result.getPushResult(uri).getRemoteUpdate(dstRefName);
+	}
+
+	Ref getAdvertisedRemoteRef(final URIish uri) {
+		return result.getPushResult(uri).getAdvertisedRef(dstRefName);
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java
new file mode 100644
index 0000000..920494f
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java
@@ -0,0 +1,65 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.push;
+
+import org.eclipse.jface.dialogs.Dialog;
+import org.eclipse.jface.dialogs.IDialogConstants;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Shell;
+import org.spearce.egit.core.op.PushOperationResult;
+import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Repository;
+
+class ResultDialog extends Dialog {
+	private final Repository localDb;
+
+	private final PushOperationResult result;
+
+	private final String destinationString;
+
+	ResultDialog(final Shell parentShell, final Repository localDb,
+			final PushOperationResult result, final String destinationString) {
+		super(parentShell);
+		setShellStyle(getShellStyle() | SWT.RESIZE);
+		this.localDb = localDb;
+		this.result = result;
+		this.destinationString = destinationString;
+	}
+
+	@Override
+	protected void createButtonsForButtonBar(final Composite parent) {
+		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL,
+				true);
+	}
+
+	@Override
+	protected Control createDialogArea(final Composite parent) {
+		final Composite composite = (Composite) super.createDialogArea(parent);
+
+		final Label label = new Label(composite, SWT.NONE);
+		label.setText(NLS.bind(UIText.ResultDialog_label, destinationString));
+		label.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, false));
+		final PushResultTable table = new PushResultTable(composite);
+		table.setData(localDb, result);
+		final Control tableControl = table.getControl();
+		final GridData tableLayout = new GridData(SWT.FILL, SWT.FILL, true,
+				true);
+		tableLayout.widthHint = 650;
+		tableLayout.heightHint = 300;
+		tableControl.setLayoutData(tableLayout);
+
+		getShell().setText(
+				NLS.bind(UIText.ResultDialog_title, destinationString));
+		return composite;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index f2be3c1..4b0aea6 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -179,6 +179,53 @@ HistoryPage_findbar_notFound=String not found
 
 HistoryPreferencePage_title=Git
 
+PushWizard_cantConnectToAny=Can't connect to any repository: {0}
+PushWizard_cantPrepareUpdatesMessage=Can't resolve ref specifications locally (local refs changed?) or create tracking ref update.
+PushWizard_cantPrepareUpdatesTitle=Preparing Ref Updates Error
+PushWizard_cantSaveMessage=Couldn't save specified specifications in configuration file.
+PushWizard_cantSaveTitle=Configuration Storage Warning
+PushWizard_jobName=Pushing to...{0}
+PushWizard_missingRefsMessage=Ref specifications don't match any source ref (local refs changed?).
+PushWizard_missingRefsTitle=Missing Refs Error
+PushWizard_unexpectedError=Unexpected error occurred.
+PushWizard_windowTitleDefault=Push To Another Repositories
+PushWizard_windowTitleWithDestination=Push To: {0}
+
+ConfirmationPage_cantConnectToAny=Can't connect to any URI: {0}
+ConfirmationPage_description=Confirm following expected push result.
+ConfirmationPage_errorCantResolveSpecs=Can't resolve ref specifications locally or create tracking ref update: {0} 
+ConfirmationPage_errorInterrupted=Operation was interrupted.
+ConfirmationPage_errorRefsChangedNoMatch=Local refs changed, ref specifications don't match any source ref.
+ConfirmationPage_errorUnexpected=Unexpected error occurred: {0}
+ConfirmationPage_requireUnchangedButton=Push only if remote refs don't change in the mean time
+ConfirmationPage_showOnlyIfChanged=Show final report dialog only when it differs from this confirmation report
+ConfirmationPage_title=Push Confirmation
+
+PushResultTable_columnStatusRepo=Status: Repo #{0}
+PushResultTable_columnDst=Destination Ref
+PushResultTable_columnSrc=Source Ref
+PushResultTable_columnMode=Mode
+PushResultTable_statusUnexpected=Unexpected update status: {0} 
+PushResultTable_statusConnectionFailed=[connection failed]
+PushResultTable_statusDetailChanged=remote ref object changed,\nnow it's: {0},\nnot expected: {1}
+PushResultTable_refNonExisting=(non existing)
+PushResultTable_statusDetailDeleted=old value: {0} 
+PushResultTable_statusDetailNonFastForward=non-fast forward
+PushResultTable_statusDetailNoDelete=remote side does not support deleting refs
+PushResultTable_statusDetailNonExisting=remote ref already does not exist
+PushResultTable_statusDetailForcedUpdate=forced update (non-fast forward)
+PushResultTable_statusDetailFastForward=fast forward
+PushResultTable_statusRemoteRejected=[remote rejected]
+PushResultTable_statusRejected=[rejected]
+PushResultTable_statusNoMatch=[no match]
+PushResultTable_statusUpToDate=[up to date]
+PushResultTable_statusOkDeleted=[deleted]
+PushResultTable_statusOkNewBranch=[new branch]
+PushResultTable_statusOkNewTag=[new tag]
+	
+ResultDialog_title=Push Results: {0}
+ResultDialog_label=Pushed to {0}.
+
 WindowCachePreferencePage_title=Git Window Cache
 WindowCachePreferencePage_packedGitWindowSize=Window size:
 WindowCachePreferencePage_packedGitLimit=Window cache limit:
-- 
1.5.6.3
