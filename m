From: Eric Wong <e@80x24.org>
Subject: [PATCH] .mailmap: update to my shorter email address
Date: Mon,  2 May 2016 19:31:21 +0000
Message-ID: <20160502193121.29081-1-e@80x24.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <e@80x24.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:39:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJgN-0003eI-8T
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbcEBTjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 15:39:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45942 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbcEBTi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:38:58 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 May 2016 15:38:58 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D211C2018D;
	Mon,  2 May 2016 19:31:28 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293277>

=46ollowing f916ab0ccc ("send-email: more meaningful Message-ID"),
my own email address is too long :x

While I could have an even shorter address by one character with
"yhbt.net", "80x24.org" is more representative of my
hacking-related pursuits.

Signed-off-by: Eric Wong <e@80x24.org>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e5b4126..a9162c0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -51,6 +51,7 @@ Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
 Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
 Eric S. Raymond <esr@thyrsus.com>
+Eric Wong <e@80x24.org> <normalperson@yhbt.net>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.n=
tnu.no>
 Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achl=
eitner2.6.31@gmail.com>
--=20
EW
