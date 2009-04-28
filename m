From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] parseopt: fix documentation for --keep-dashdash
Date: Tue, 28 Apr 2009 22:29:24 +0200
Message-ID: <1240950564-15124-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1240950564-15124-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 22:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LytwU-0000eP-GN
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 22:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbZD1U3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 16:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbZD1U3f
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 16:29:35 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43725 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZD1U3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 16:29:35 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lytvn-0000Av-56; Tue, 28 Apr 2009 22:29:34 +0200
X-Mailer: git-send-email 1.6.2.4
In-Reply-To: <1240950564-15124-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117807>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/git-rev-parse.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 8d3ba14..0e4746f 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -26,7 +26,7 @@ OPTIONS
 --parseopt::
 	Use 'git-rev-parse' in option parsing mode (see PARSEOPT section belo=
w).
=20
---keep-dash-dash::
+--keep-dashdash::
 	Only meaningful in `--parseopt` mode. Tells the option parser to echo
 	out the first `--` met instead of skipping it.
=20
--=20
1.6.2.4
