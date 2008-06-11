From: Jeff King <peff@peff.net>
Subject: [PATCH] fix typo in tutorial
Date: Wed, 11 Jun 2008 19:09:48 -0400
Message-ID: <20080611230948.GE19474@sigill.intra.peff.net>
References: <c647e93f0806111434q1cf99ff5pa99858c56951beeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fred =?utf-8?B?TWFyYW5ow6Nv?= <fred.maranhao@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ZSq-0001VZ-SK
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386AbYFKXJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 19:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYFKXJv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:09:51 -0400
Received: from peff.net ([208.65.91.99]:3644 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438AbYFKXJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:09:50 -0400
Received: (qmail 15224 invoked by uid 111); 11 Jun 2008 23:09:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 11 Jun 2008 19:09:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jun 2008 19:09:48 -0400
Content-Disposition: inline
In-Reply-To: <c647e93f0806111434q1cf99ff5pa99858c56951beeb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84681>

=46rom: Fred Maranh=C3=A3o <fred.maranhao@gmail.com>

Signed-off-by: Jeff King <peff@peff.net>
---
On Wed, Jun 11, 2008 at 06:34:15PM -0300, Fred Maranh=C3=A3o wrote:

> It seems that there is a little typo in git tutorial
> (http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html).In

Thanks. Patch-ified for Junio's convenience.

 Documentation/gittutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.=
txt
index 9563a63..d465aab 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -114,7 +114,7 @@ newly modified content to the index.  Finally, comm=
it your changes with:
 $ git commit
 ------------------------------------------------
=20
-This will again prompt your for a message describing the change, and t=
hen
+This will again prompt you for a message describing the change, and th=
en
 record a new version of the project.
=20
 Alternatively, instead of running `git add` beforehand, you can use
--=20
1.5.6.rc2.158.g5896e
