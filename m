From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] .mailmap: switch to Thomas Rast's personal address
Date: Sun, 13 Oct 2013 16:07:49 +0200
Message-ID: <e20acd8f94a8b2524cfc1ec9665f998fbd5dbf68.1381645346.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 13 16:08:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVML6-0007oY-5i
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 16:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab3JMOHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 10:07:53 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33197 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3JMOHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 10:07:52 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 13 Oct
 2013 16:07:49 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.223) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 13 Oct
 2013 16:07:49 +0200
X-Mailer: git-send-email 1.8.4.1.661.g6b832f5
X-Originating-IP: [213.55.184.223]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236076>

Normalize to my personal address, as my ETH addresses will expire
soon.  Also add my new corp account to be somewhat futureproof.

Note that despite the private address being first, Google owns the
copyright as long as I am employed there.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 .mailmap | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 1c1f5ec..11057cb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -218,7 +218,9 @@ Tay Ray Chuan <rctay89@gmail.com>
 Ted Percival <ted@midg3t.net> <ted.percival@quest.com>
 Theodore Ts'o <tytso@mit.edu>
 Thomas Ackermann <th.acker@arcor.de> <th.acker66@arcor.de>
-Thomas Rast <trast@inf.ethz.ch> <trast@student.ethz.ch>
+Thomas Rast <tr@thomasrast.ch> <trast@student.ethz.ch>
+Thomas Rast <tr@thomasrast.ch> <trast@inf.ethz.ch>
+Thomas Rast <tr@thomasrast.ch> <trast@google.com>
 Timo Hirvonen <tihirvon@gmail.com> <tihirvon@ee.oulu.fi>
 Toby Allsopp <Toby.Allsopp@navman.co.nz> <toby.allsopp@navman.co.nz>
 Tom Grennan <tmgrennan@gmail.com> <tgrennan@redback.com>
-- 
1.8.4.1.661.g6b832f5
