From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 4/4] Add a JUnit test project for egit.
Date: Tue, 24 Apr 2007 00:41:44 +0200
Organization: Dewire
Message-ID: <200704240041.44466.robin.rosenberg.lists@dewire.com>
References: <20070422212907.26396.12810.stgit@lathund.dewire.com> <20070422213615.26396.98374.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Apr 24 00:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg7EJ-0005hO-Tk
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 00:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbXDWWlx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 18:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbXDWWlx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 18:41:53 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25112 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbXDWWlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 18:41:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DFA538028A0;
	Tue, 24 Apr 2007 00:35:58 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07635-04; Tue, 24 Apr 2007 00:35:58 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 9466E802873;
	Tue, 24 Apr 2007 00:35:58 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070422213615.26396.98374.stgit@lathund.dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45373>

Match the version number of this plugin.

-- robin

diff --git a/org.spearce.egit.core.test/META-INF/MANIFEST.MF b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
index e201e46..667100f 100644
--- a/org.spearce.egit.core.test/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
@@ -2,7 +2,7 @@ Manifest-Version: 1.0
 Bundle-ManifestVersion: 2
 Bundle-Name: Test Plug-in
 Bundle-SymbolicName: org.spearce.egit.core.test
-Bundle-Version: 0.2.0
+Bundle-Version: 0.2.1.qualifier
 Bundle-Activator: org.spearce.egit.core.test.Activator
 Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.team.core,
