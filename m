From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH 3/4] Add git-pack-intersect to .gitignore
Date: Wed, 09 Nov 2005 02:24:51 +0100
Organization: Chalmers
Message-ID: <43714FE3.8020101@etek.chalmers.se>
References: <43714EFB.5070705@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 09 02:25:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZehU-0000R2-HF
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbVKIBYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 Nov 2005 20:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVKIBYa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:24:30 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:4269 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030495AbVKIBY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 20:24:29 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 436FB1AD000617F5; Wed, 9 Nov 2005 02:24:29 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43714EFB.5070705@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11381>

Add git-pack-intersect to .gitignore

Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

---

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: f4f7accfd9ee93f528c85bae514334fbc7a70be7
7b8da40e79aa09b43ba4590c6bf8169ed85e4871
diff --git a/.gitignore b/.gitignore
index 716c340..6ff2530 100644
--- a/.gitignore
+++ b/.gitignore
@@ -60,6 +60,7 @@ git-mktag
 git-name-rev
 git-mv
 git-octopus
+git-pack-intersect
 git-pack-objects
 git-parse-remote
 git-patch-id
---
0.99.9.GIT
