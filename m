From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: fix reference to a for-each-ref option
Date: Mon,  1 Sep 2008 23:02:09 +0200
Message-ID: <1220302929-8858-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 23:03:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaGYg-00012X-0f
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 23:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbYIAVC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 17:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYIAVC1
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:02:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:57113 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYIAVC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:02:26 -0400
Received: from [127.0.1.1] (p5B13393C.dip0.t-ipconnect.de [91.19.57.60])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1KaGXJ1oly-00032S; Mon, 01 Sep 2008 23:02:10 +0200
X-Mailer: git-send-email 1.6.0.1.171.gaaac
X-Provags-ID: V01U2FsdGVkX18YEhmviNgx+x8ghRvt5jiX9i1MLibADJI4gxY
 CL51jkPp/4WW0dUvYG9G6lDkIhhgbK25NaM1oeCT9n0yBO69VP
 MGwqjoBRsTd0o0w1PezwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94609>

=2E.. to match the synopsis section

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-for-each-ref.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index eae6c0e..ebd7c5f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -16,7 +16,7 @@ DESCRIPTION
=20
 Iterate over all refs that match `<pattern>` and show them
 according to the given `<format>`, after sorting them according
-to the given set of `<key>`.  If `<max>` is given, stop after
+to the given set of `<key>`.  If `<count>` is given, stop after
 showing that many refs.  The interpolated values in `<format>`
 can optionally be quoted as string literals in the specified
 host language allowing their direct evaluation in that language.
--=20
1.6.0.1.171.gaaac
