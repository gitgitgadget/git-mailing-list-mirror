From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 01/11] Use tabs for indenting definition list for options in git-log.txt
Date: Sat, 16 Jun 2007 21:03:37 +0200
Message-ID: <11820206303537-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdTV-0007Dl-08
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbXFPS6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbXFPS6N
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:8389 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbXFPS6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101905ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N6FyCKK1YtOkogKNFZipA26KctjAlyeX0gK9jGo0L0Xr9J+EN785FYb+fhVnhyw/59yXETwgM53K8AE3e54f/QN7N+SVfcrZCmiNtunbZgWt6sfyhHgN2aovSrb/Ai302VME8N0z3Ud93vqtz3rP/QM7uOxhZqH1T8zqgg0OgO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EZ0oGpkSuSbpx8uIpl/2iyG6OZi4MUGDlQ6vAm5+Zm0vKYAX9WEAT6m/fovCUmRdvWifuJLjUQMggkAacCSmndJdW7HQILi3qbtkRz2KToHxbhWqz/3eLUu/sR7ZVZPy/SVKWXbcm2uwHnv73alnx6qAiMYQBuweWU45KBkOAbo=
Received: by 10.82.189.6 with SMTP id m6mr8137837buf.1182020289828;
        Sat, 16 Jun 2007 11:58:09 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id d24sm6237527nfh.2007.06.16.11.58.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:09 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3o4x004226;
	Sat, 16 Jun 2007 21:03:51 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3ovd004225;
	Sat, 16 Jun 2007 21:03:50 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50294>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-log.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6157edb..c072441 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -52,7 +52,7 @@ include::pretty-options.txt[]
 	See also gitlink:git-reflog[1].
 
 --decorate::
-    Print out the ref names of any commits that are shown.
+	Print out the ref names of any commits that are shown.
 
 <paths>...::
 	Show only commits that affect the specified paths.
-- 
1.5.2
