From: Tim Harper <timcharper@gmail.com>
Subject: [PATCH] added OS X package downloads
Date: Thu,  3 Apr 2008 23:55:11 -0600
Message-ID: <1207288511-19478-1-git-send-email-timcharper@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Tim Harper <timcharper@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 07:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JheuZ-0000ej-TV
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 07:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYDDFzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 01:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYDDFzn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 01:55:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:28737 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYDDFzm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 01:55:42 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2718830wra.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=GiurEIfLuh++SAoCZaHb+f78w+OR08sPM/cqQX615cg=;
        b=OQSFFVxyxyTkzzqMawzcnlCvangT6u4ySsjJU7hPO435SgqDVLZbqxocPjpDppR7AS78X4OBuMhJZC1YWxV2b3wNSI1u0Gw8CkH17+8zduALeDSTMQsp88F5ERo6rWgtvBvt4OoHC9udVJXC+4ySw3HuTj7T7cLSRjfOGR0B1Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dXH1VHLuWdC3sRH00P1ouXlz9y07yIivUerNwe87nbb8wf++CTTr2Rofm4/geSBb1qI1unyVamUz2R53QSyQBOtuy5+2tLfByXAe7xEattB0InmhLlV2Bqukjh0tVqVGca1P1Coxmlwm6ZNzqdfyFNFJK6TyI0XIECr0fwa8zqA=
Received: by 10.115.111.1 with SMTP id o1mr1204023wam.87.1207288541137;
        Thu, 03 Apr 2008 22:55:41 -0700 (PDT)
Received: from localhost ( [208.186.134.104])
        by mx.google.com with ESMTPS id v32sm8298272wah.42.2008.04.03.22.55.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Apr 2008 22:55:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78792>

---
 index.html |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/index.html b/index.html
index 5b7e281..afe6e13 100644
--- a/index.html
+++ b/index.html
@@ -246,6 +246,14 @@ You can also use one of many <a href="http://www.kernel.org/mirrors/">kernel.org
 <td><a href="http://code.google.com/p/msysgit/downloads/list">http://code.google.com/p/msysgit/downloads/list</a></td>
 </tr>
 
+<tr class="odd">
+<td rowspan="3">OS X</td>
+</tr>
+<tr>
+<td>Stable</td>
+<td><a href="http://code.google.com/p/git-osx-installer/downloads/list?can=3&q=&sort=-uploaded&colspec=Filename+Summary+Uploaded+Size+DownloadCount">http://code.google.com/p/git-osx-installer/downloads/list?can=3</a></td>
+</tr>
+
 </table>
 
 <h3>Development snapshots</h3>
-- 
1.5.4.5
