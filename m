From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] .mailmap: Map the the first submissions of MJG by e-mail
Date: Sun, 21 Mar 2010 14:43:47 +0100
Message-ID: <8863d2d4e721a16ed13ce1518be6c5f272c59d06.1269178932.git.git@drmicha.warpmail.net>
References: <4BA620CD.3060101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 14:43:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtLRI-0007zE-1u
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 14:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab0CUNn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 09:43:29 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36989 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab0CUNn2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 09:43:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F23ADE99E6;
	Sun, 21 Mar 2010 09:43:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 21 Mar 2010 09:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=4n05zR8OoqX65z3Pqyr8cOZs/4c=; b=UkkIio/SBJZP/bTXdAGPeyHwgFy7QQGhxQbgZSSZgLK5GknI7VbvHnoS30JKgfQ7cqHeNqbTz5sISlv/tSNaFaEteNGByzaWDZ3ffTbhM9WviYRa/FtY84uo7inJBZn8HtLvs2xH+MLIc0oD47H0XxuX5xuc8GOOwvUpP67/URY=
X-Sasl-enc: 6kEMCb2Jrvz14ZC5Mow2BCiUZnRBsdkgrxY/AdXtzmDP 1269179007
Received: from localhost (p3EE280DF.dip0.t-ipconnect.de [62.226.128.223])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 461CC11068;
	Sun, 21 Mar 2010 09:43:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.358.g30511
In-Reply-To: <4BA620CD.3060101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142827>

so that git shortlog with '-e' coalesces all my commits.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 .mailmap |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.mailmap b/.mailmap
index c507309..a8091eb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -38,6 +38,7 @@ Li Hong <leehong@pku.edu.cn>
 Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
 Martin Langhoff <martin@catalyst.net.nz>
 Michael Coleman <tutufan@gmail.com>
+Michael J Gruber <git@drmicha.warpmail.net> <michaeljgruber+gmane@fast=
mail.fm>
 Michael W. Olson <mwolson@gnu.org>
 Michele Ballabio <barra_cuda@katamail.com>
 Nanako Shiraishi <nanako3@bluebottle.com>
--=20
1.7.0.2.358.g30511
