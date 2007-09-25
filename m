From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Remove 'submodules' from the TODO section of the User
	Manual.
Date: Tue, 25 Sep 2007 21:11:59 +0200
Message-ID: <20070925191159.GG18370@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 21:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaFpL-0005Q1-VR
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbXIYTME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbXIYTME
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:12:04 -0400
Received: from virgo.iok.hu ([193.202.89.103]:58011 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273AbXIYTMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:12:03 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3B3D91B2515;
	Tue, 25 Sep 2007 21:12:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1933A6FCE9;
	Tue, 25 Sep 2007 21:11:59 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E070213A4126; Tue, 25 Sep 2007 21:11:59 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59154>

A chapter about this topic has been added recently.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

i forgot to include this change in my previous patch, so here is the
correction.

 Documentation/user-manual.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a085ca1..e4b04d0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4277,5 +4277,3 @@ Write a chapter on using plumbing and writing scripts.
 Alternates, clone -reference, etc.
 
 git unpack-objects -r for recovery
-
-submodules
-- 
1.5.3.2.80.g077d6f-dirty
