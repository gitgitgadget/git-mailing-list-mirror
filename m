From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Documentation/merge subtree How-To: fix typo
Date: Wed,  9 Feb 2011 10:04:43 +0100
Message-ID: <1297242283-11532-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 10:04:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn5yp-0004vY-9s
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 10:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab1BIJEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 04:04:48 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37131 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab1BIJEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 04:04:46 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pn5yf-0002kd-5g; Wed, 09 Feb 2011 10:04:45 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pn5yf-00030X-4R; Wed, 09 Feb 2011 10:04:45 +0100
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166397>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/howto/using-merge-subtree.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentatio=
n/howto/using-merge-subtree.txt
index 0953a50..2933056 100644
--- a/Documentation/howto/using-merge-subtree.txt
+++ b/Documentation/howto/using-merge-subtree.txt
@@ -71,5 +71,5 @@ Additional tips
   relevant parts of your tree.
=20
 - Please note that if the other project merges from you, then it will
-  connects its history to yours, which can be something they don't wan=
t
+  connect its history to yours, which can be something they don't want
   to.
--=20
1.7.2.3
