From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] some feedbacks from the Italian Free Translation Project.
Date: Sun, 22 Jul 2007 20:19:42 +0200
Message-ID: <20070722201942.609543f1@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 20:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICg14-0005hf-I6
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775AbXGVSSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757646AbXGVSSr
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:18:47 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:34984 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757504AbXGVSSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 14:18:46 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1090327hue
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 11:18:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=I+Or69sThU2hDw449e2zSVh6n/ddSUm172g9MnZSY17KA4gaprzEcZmXSO6d084F+X3cqQxr37w/GxcIeCIc1T4TWcLfndLZ9VcC0j30ey2LzBk0Z9YAGiU2D1hKzOTDzIQFNkK+v1y2569eskV8ueOdAH+NsHwdvQEJZ+70oVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YbqsXC5ig7a7sk0WZKkqZl+EWN2upNZDbexLYdnulURPP4O467fZj2ivdpE2oPP8ttmWcs89b6xOH/A4Ue6lVrZXZn2384kk4vC35/dvsOF6YJACe9Pq+HiOWLQ+tpF2lBUgg3Bqguq0DMU8ldlsZmIfLWMUTxG37lLMYlQHFsY=
Received: by 10.66.239.2 with SMTP id m2mr3602135ugh.1185128325020;
        Sun, 22 Jul 2007 11:18:45 -0700 (PDT)
Received: from paolo-desktop ( [82.50.0.11])
        by mx.google.com with ESMTPS id 2sm13143527nfv.2007.07.22.11.18.43
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 11:18:44 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53285>

Many thanks to the Italian Free Translation Project

More patches in the following days.=20

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 po/it.po |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/it.po b/po/it.po
index 162e187..6879d66 100644
--- a/po/it.po
+++ b/po/it.po
@@ -195,11 +195,11 @@ msgstr "Ramo corrente:"
=20
 #: git-gui.sh:2115
 msgid "Staged Changes (Will Be Committed)"
-msgstr "Modifiche preparate (Saranno committate)"
+msgstr "Modifiche preparate (ne verr=E0 effettuato il commit)"
=20
 #: git-gui.sh:2135
 msgid "Unstaged Changes (Will Not Be Committed)"
-msgstr "Modifiche non preparate (Non saranno committate)"
+msgstr "Modifiche non preparate (non ne verr=E0 effettuato il commit)"
=20
 #: git-gui.sh:2182
 msgid "Add Existing"
--=20
1.5.3.rc2.29.gc4640f
