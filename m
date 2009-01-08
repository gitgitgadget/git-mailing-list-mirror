From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 7/7] Create an automatic UI test for the Git Import Wizard
Date: Thu, 8 Jan 2009 19:45:40 +0100
Message-ID: <200901081945.41067.robin.rosenberg.lists@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com> <1231433791-9267-7-git-send-email-robin.rosenberg@dewire.com> <1231433791-9267-8-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 20:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKzuj-00070G-3g
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 19:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761167AbZAHSpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 13:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760381AbZAHSps
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 13:45:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:26324 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760271AbZAHSpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 13:45:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4DDD91484F6F;
	Thu,  8 Jan 2009 19:45:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GcKRy+bsGOCw; Thu,  8 Jan 2009 19:45:42 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C65761484F6D;
	Thu,  8 Jan 2009 19:45:42 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1231433791-9267-8-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104948>

Oops. We should not require Java 6 yet. Please squash this in.

-- robin

diff --git a/org.spearce.egit.ui.test/.classpath b/org.spearce.egit.ui.test/.classpath
index 76279f3..13116da 100644
--- a/org.spearce.egit.ui.test/.classpath
+++ b/org.spearce.egit.ui.test/.classpath
@@ -1,6 +1,6 @@
 <?xml version="1.0" encoding="UTF-8"?>
 <classpath>
-	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.6"/>
+	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/J2SE-1.5"/>
 	<classpathentry kind="con" path="org.eclipse.pde.core.requiredPlugins"/>
 	<classpathentry kind="src" path="src"/>
 	<classpathentry kind="con" path="org.eclipse.jdt.junit.JUNIT_CONTAINER/3"/>
