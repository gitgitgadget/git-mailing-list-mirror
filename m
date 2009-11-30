From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH] Documentation: Document --branch option in git clone synopsis
Date: Mon, 30 Nov 2009 14:27:52 +0100
Message-ID: <1259587672-15076-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 14:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF6IR-00028r-0N
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 14:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbZK3N1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 08:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbZK3N1z
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 08:27:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:40331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751515AbZK3N1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 08:27:54 -0500
Received: (qmail invoked by alias); 30 Nov 2009 13:27:59 -0000
Received: from e180064012.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.64.12]
  by mail.gmx.net (mp013) with SMTP; 30 Nov 2009 14:27:59 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1+JgT5vCpeJmdmPnC5oiLGSr8gehKSQVwb7wt8MYI
	jr1Grm52NH2T+n
X-Mailer: git-send-email 1.6.6.rc0.268.g1c272
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134101>

From: David Soria Parra <dsp@php.net>

Document the --branch option as [-b <name>] in git clones synopsis.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 Documentation/git-clone.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7e7d9fc..7ccd742 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
-	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
+	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--depth <depth>] [--recursive] [--] <repository> [<directory>]
 
 DESCRIPTION
-- 
1.6.6.rc0.268.g1c272
