From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 4/8] Doc: 'git' has a discussion section
Date: Wed, 19 Sep 2012 00:25:30 +0100
Message-ID: <1348010734-664-5-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7A4-0005Bj-5A
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab2IRXYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:24:50 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:57860 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752192Ab2IRXYr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFADrwWFBZ8rU+/2dsb2JhbABFhSC3IoEJgn07gQIkE4gEB5h4oVGSCwOmBIJn
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="404115682"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:45 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205888>

Highlight there is a further discussion section later in
git man page

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 34d8a1b..d932a3e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -30,6 +30,7 @@ After you mastered the basic concepts, you can come back to this
 page to learn what commands git offers.  You can learn more about
 individual git commands with "git help command".  linkgit:gitcli[7]
 manual page gives you an overview of the command line command syntax.
+See also the Discussion and Further Documentation sections below.
 
 Formatted and hyperlinked version of the latest git documentation
 can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
-- 
1.7.8.msysgit.0
