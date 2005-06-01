From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One-Git Part 2 (Patch 1/3)
Date: Wed, 1 Jun 2005 14:22:58 -0400
Message-ID: <20050601182258.GA2655@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 20:33:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdXxr-0003ul-Uf
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 20:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVFASbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFASbB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 14:31:01 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:46543 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261560AbVFASXC
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 14:23:02 -0400
Received: by timesys.com (Postfix, from userid 623)
	id 47281EB2F; Wed,  1 Jun 2005 14:22:58 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add: Empty documentation for some scripts

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/Documentation/git-commit-script.txt b/Documentation/git-commit-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-commit-script.txt
@@ -0,0 +1,29 @@
+git-commit-script(1)
+====================
+v0.1, May 2005
+
+NAME
+----
+git-commit-script - Commit working directory
+
+
+SYNOPSIS
+--------
+'git-commit-script' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-deltafy-script.txt b/Documentation/git-deltafy-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-deltafy-script.txt
@@ -0,0 +1,29 @@
+git-deltafy-script(1)
+=====================
+v0.1, May 2005
+
+NAME
+----
+git-deltafy-script - Convery repository into delta format
+
+
+SYNOPSIS
+--------
+'git-deltafy-script'
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-fetch-script.txt b/Documentation/git-fetch-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-fetch-script.txt
@@ -0,0 +1,29 @@
+git-fetch-script(1)
+===================
+v0.1, May 2005
+
+NAME
+----
+git-fetch-script - Fetch an object from a remote repository
+
+
+SYNOPSIS
+--------
+'git-fetch-script' <sha1>
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-log-script.txt b/Documentation/git-log-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-log-script.txt
@@ -0,0 +1,29 @@
+git-log-script(1)
+=================
+v0.1, May 2005
+
+NAME
+----
+git-log-script - Prettified version of git-rev-list
+
+
+SYNOPSIS
+--------
+'git-log-script' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-status-script.txt b/Documentation/git-status-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-status-script.txt
@@ -0,0 +1,29 @@
+git-status-script(1)
+====================
+v0.1, May 2005
+
+NAME
+----
+git-status-script - Show status of working directory files
+
+
+SYNOPSIS
+--------
+'git-status-script' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
======== end ========

