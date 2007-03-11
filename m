From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 1/2] Tag version 0.2.1
Date: Sun, 11 Mar 2007 21:11:42 +0100
Message-ID: <20070311201142.23073.84739.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 21:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUMk-0006pw-8H
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbXCKUJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbXCKUJ4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:09:56 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2378 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbXCKUJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:09:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 467CD802843;
	Sun, 11 Mar 2007 21:04:40 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27012-06; Sun, 11 Mar 2007 21:04:40 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id F193B802841;
	Sun, 11 Mar 2007 21:04:39 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 3DEE4297C9;
	Sun, 11 Mar 2007 21:11:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id o50U1TK4TeM0; Sun, 11 Mar 2007 21:11:45 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id F186029886;
	Sun, 11 Mar 2007 21:11:42 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41967>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 org.spearce.egit.core/META-INF/MANIFEST.MF |    2 +-
 org.spearce.egit.ui/META-INF/MANIFEST.MF   |    2 +-
 org.spearce.jgit/META-INF/MANIFEST.MF      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index 13ec59d..fd90a0c 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -2,7 +2,7 @@ Manifest-Version: 1.0
 Bundle-ManifestVersion: 2
 Bundle-Name: %plugin_name
 Bundle-SymbolicName: org.spearce.egit.core; singleton:=true
-Bundle-Version: 0.2.0.qualifier
+Bundle-Version: 0.2.1
 Bundle-Activator: org.spearce.egit.core.Activator
 Bundle-Vendor: %provider_name
 Bundle-Localization: plugin
diff --git a/org.spearce.egit.ui/META-INF/MANIFEST.MF b/org.spearce.egit.ui/META-INF/MANIFEST.MF
index 63dcec8..8075883 100644
--- a/org.spearce.egit.ui/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.ui/META-INF/MANIFEST.MF
@@ -2,7 +2,7 @@ Manifest-Version: 1.0
 Bundle-ManifestVersion: 2
 Bundle-Name: %plugin_name
 Bundle-SymbolicName: org.spearce.egit.ui; singleton:=true
-Bundle-Version: 0.2.0.qualifier
+Bundle-Version: 0.2.1
 Bundle-Activator: org.spearce.egit.ui.Activator
 Bundle-Vendor: %plugin_provider
 Bundle-Localization: plugin
diff --git a/org.spearce.jgit/META-INF/MANIFEST.MF b/org.spearce.jgit/META-INF/MANIFEST.MF
index 1485bb9..9bbddb3 100644
--- a/org.spearce.jgit/META-INF/MANIFEST.MF
+++ b/org.spearce.jgit/META-INF/MANIFEST.MF
@@ -2,7 +2,7 @@ Manifest-Version: 1.0
 Bundle-ManifestVersion: 2
 Bundle-Name: %plugin_name
 Bundle-SymbolicName: org.spearce.jgit
-Bundle-Version: 0.2.0.qualifier
+Bundle-Version: 0.2.1
 Bundle-Localization: plugin
 Bundle-Vendor: %provider_name
 Export-Package: org.spearce.jgit.errors,
