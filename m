From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: gitview: Bump the rev
Date: Fri, 24 Feb 2006 14:08:35 +0530
Message-ID: <cc723f590602240038u1e0a7fe1q233655bc01fa96f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5495_14939821.1140770315320"
X-From: git-owner@vger.kernel.org Fri Feb 24 09:39:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCYTY-0005c2-Na
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 09:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWBXIii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 03:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBXIii
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 03:38:38 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:34010 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932111AbWBXIih (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 03:38:37 -0500
Received: by uproxy.gmail.com with SMTP id h2so108836ugf
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 00:38:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=N+0Y3JyOnWey/zQK9jtZ/O/PDiLgsweIkD9yD8xdntpG9WqT6cinIQNFcM/VPHzBNW/5krs8ul3J9WAy5SR1aFrWfnM9t4NyXD0sv0ftkhq37XUOdKslTBa35CwY6/Y2sZ2nMB98aAC74Db+fJEsTLWvb0iys/xNm6GoQSsCriA=
Received: by 10.67.23.17 with SMTP id a17mr4180920ugj;
        Fri, 24 Feb 2006 00:38:35 -0800 (PST)
Received: by 10.66.254.7 with HTTP; Fri, 24 Feb 2006 00:38:35 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16688>

------=_Part_5495_14939821.1140770315320
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_5495_14939821.1140770315320
Content-Type: text/plain; name=0003-gitview-Bump-the-rev.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek296dff
Content-Disposition: attachment; filename="0003-gitview-Bump-the-rev.txt"

Subject: gitview: Bump the rev
Make the 0.7 release
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

32e92e4586a4b48c2d4776bcb7ba885f5c710935
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 4a6b448..02e2445 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -422,7 +422,7 @@ class DiffWindow:
 class GitView:
 	""" This is the main class
 	"""
-	version = "0.6"
+	version = "0.7"
 
 	def __init__(self, with_diff=0):
 		self.with_diff = with_diff
-- 
1.2.3.g2cf3-dirty


------=_Part_5495_14939821.1140770315320--
