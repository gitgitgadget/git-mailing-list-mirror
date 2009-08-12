From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT 1/5] TODO: Update and retitle to "JGit Wishlist"
Date: Wed, 12 Aug 2009 10:33:19 -0400
Message-ID: <2c6b72b30908120733g3296fb8s5673946d468f2638@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 16:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbEuJ-0002Uh-MZ
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 16:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZHLOdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbZHLOdj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 10:33:39 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:61707 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbZHLOdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 10:33:38 -0400
Received: by qyk34 with SMTP id 34so40222qyk.33
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4OIELE6HEk98fv41RGQC8DSMLHPIwP0/Bg2YpawJHHs=;
        b=bHtAIXPxH2kyOETojrzRhtaSq2krqFaO6iBk+iGO+c4Jneeg3cKQSJYkPOPce/rki/
         kw754oJU/89tYFgOantku1nQvxR32KkoG+J8g1TGk5X8Sl0rgvnpdbplY3GiKiknC89d
         iPpCXxjFGMUGDsnMrm9qrxQdznE1jGM7L+nlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=oo0YawMyckkyj9KYf+FqOErKaC04tM9I0L03QFIa6SaYdkMqtxcaWHArWyF3zCNlwI
         SCZAnoXN8+U+k0ZYhKMgAA+v9ZvPkkDD18p8J26JWiElMO7yrjtGibDwKmpKrR6z6nxR
         OMExVLnjUOZAVrZ38qWDcCa71ykXv0ojslr28=
Received: by 10.224.117.145 with SMTP id r17mr145228qaq.7.1250087619161; Wed, 
	12 Aug 2009 07:33:39 -0700 (PDT)
X-Google-Sender-Auth: 42dc0adec0dcb4f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125702>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 TODO |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/TODO b/TODO
index 5f35b25..c4ce95e 100644
--- a/TODO
+++ b/TODO
@@ -1,15 +1,9 @@
-= Eclipse Plugin Wishlist =
+= JGit Wishlist =

-Now that we have some basic features in the Eclipse plugin, we need
-to focus on making it usable by average users doing daily tasks.
+Below are some of the areas that needs work. Also take a look at JGit
+related issues in the EGit project:

-== Create Branch ==
-
-Create a new branch from any revision specification.
-
-== Delete Branch ==
-
-Delete a branch.
+ - http://code.google.com/p/egit/issues/list?q=label:Component-JGit

 == Switch Branch ==

-- 
1.6.4.rc3.195.g2b05f
