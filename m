From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] course/svn: Fix a link pointing to a .txt instead of its
 .html page
Date: Sat, 01 Sep 2007 05:41:40 +0200
Message-ID: <46D8DF74.6020704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 01 05:42:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRJsL-0002EF-56
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 05:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbXIADly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 23:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbXIADly
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 23:41:54 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:45765 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbXIADlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 23:41:53 -0400
Received: by fk-out-0910.google.com with SMTP id z23so765457fkz
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 20:41:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=amPH9b3FMv0jcKocDk5o1yFX7O7QROJJebDtNk6Qu81WnCFFtIn/TAAl7gqgXrGegc+pduZoWoD2jdIEmUguBqIe0VbT+6PbGdE83W8N54sOjQSaFNs2C4f7LiQgGdSuOohUSPxxfTTw8cB+PwRZp6f5Hy+Ki5XZSGfMHjOmWv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=hrcdN9cMQSB8jLoRppx5+Qp1qzHOCNfugZVj3QlQfTkOWtcIh9TEIWDmSWYoTXwOdfn9Sud/a5PPvoJNbBupPyglMs2KpMDattAJ22BYWiKM/k9fdopfe7i1lG+3aMfNbdkRTulOnTIwTvPHF5bhxak81Qv916QUM90ZO72zNrM=
Received: by 10.82.111.8 with SMTP id j8mr5294888buc.1188618111470;
        Fri, 31 Aug 2007 20:41:51 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id t38sm172215ugc.2007.08.31.20.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Aug 2007 20:41:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57248>

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 course/svn.html |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/course/svn.html b/course/svn.html
index ccadfac..fbb9d91 100644
--- a/course/svn.html
+++ b/course/svn.html
@@ -514,7 +514,7 @@ repositories with no working copy at all - so called <em>bare</em>
 repositories which are commonly used for public access or developers'
 meeting point - just for exchange of history where a checked out copy
 would be a waste of space anyway. You can create such a repository.
-See <a href="http://www.kernel.org/pub/software/scm/git/docs/user-manual.txt#setting-up-a-public-repository">Setting up a public repository</a> for details.</p>
+See <a href="http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#setting-up-a-public-repository">Setting up a public repository</a> for details.</p>

 <p>Git can work with the same workflow as Subversion, with a group of developers
 using a single repository for exchange of their work. The only change
-- 
1.5.0
