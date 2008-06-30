From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 2/7] whitespace fix in Documentation/git-repack.txt
Date: Mon, 30 Jun 2008 17:05:15 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301703340.7190@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:07:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRWM-0003pX-Pn
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763865AbYF3WFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759591AbYF3WFw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:05:52 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:38099 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763865AbYF3WFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:05:51 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5UM5GB6022663;
	Mon, 30 Jun 2008 17:05:16 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5UM5GpN007723;
	Mon, 30 Jun 2008 17:05:16 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86943>

Change leading spaces to tabs to match the rest of the file.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-repack.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 04d6f1f..9011d06 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -55,15 +55,15 @@ OPTIONS
 	Also runs linkgit:git-prune-packed[1].
 
 -l::
-        Pass the `--local` option to `git pack-objects`, see
+	Pass the `--local` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
 
 -f::
-        Pass the `--no-reuse-delta` option to `git pack-objects`, see
+	Pass the `--no-reuse-delta` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
 
 -q::
-        Pass the `-q` option to `git pack-objects`, see
+	Pass the `-q` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
 
 -n::
-- 
1.5.5.GIT
