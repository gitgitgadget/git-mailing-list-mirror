From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] GIT home page. Mentioning that Cogito is no longer
 maintained.
Date: Tue, 16 Oct 2007 19:54:25 +0200
Message-ID: <20071016195425.016cacbe@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihqch-0002s0-Gk
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbXJPRyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758693AbXJPRyV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:54:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:49777 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbXJPRyU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:54:20 -0400
Received: by ug-out-1314.google.com with SMTP id z38so128439ugc
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=gBvH3apaiyFyk5gIE8MyCT8/ro0AjZuupEg4uSbVxp0=;
        b=hKi3gU9PpN8ht5gPZv9dHJjViN3IWyHrEaJzYiTzuy+Kpu0xFhIGW5eDKn1ORB8eUz5PaPptYZRqJuH5cdxXoSm5sXTWxmEFD+mi50wNeH+Rnq/94DGmehN8lZrx13oTvx3JS68A/xITEOIPTUaSmvfsJ7QkIzvDIR3r6nKJmSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=cg9blDQp6cGZQ9tJDdY29PqH4k0lRj3/1OBCil5N/3i8xImmhwc+j5aAlgEUGt/vcQo3R3CKiwGnDFj5hIBNppifY9qIOtN9Ac0DzS7FePqmzNDsZfl4rSc23HqnnImht4CYrxswBIXw9CQKaf1914fYj5H05NubiMeDd0WBgEY=
Received: by 10.67.15.17 with SMTP id s17mr9361381ugi.1192557258100;
        Tue, 16 Oct 2007 10:54:18 -0700 (PDT)
Received: from paolo-desktop ( [87.2.69.123])
        by mx.google.com with ESMTPS id i39sm1701322ugd.2007.10.16.10.54.16
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2007 10:54:17 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61232>

As discussed on the git mailing list

	http://marc.info/?l=git&m=119252168629733&w=2

it seems to be a good idea to mention on the git home page that cogito 
is no longer maintained.

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 index.html |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/index.html b/index.html
index 340aee0..5d14acf 100644
--- a/index.html
+++ b/index.html
@@ -289,12 +289,12 @@ a gitweb interface, at <a href="http://repo.or.cz/">http://repo.or.cz/</a>.</p>
 <dt id="cogito">Cogito</dt>
 <dd>
 <a href="http://git.or.cz/cogito/">Cogito</a>
-is a popular version control system on top of Git.
-It aims at seamless user interface and ease of use, providing
-generally smoother user experience than the "raw" Git interface
-and indeed also many other version control systems. However, it
-also lacks many advanced capabilities of Git and is currently
-being slowly phased out.</dd>
+ Cogito was a popular version control system on top of Git. It aims
+at seamless user interface and ease of use, providing generally
+smoother user experience than the "raw" Git interface and indeed also
+many other version control systems. However, it also lacks many
+advanced capabilities of Git and is not actively maintained any
+longer.</dd>
 
 <dt id="stgit">StGIT</dt>
 <dd><a href="http://www.procode.org/stgit/">Stacked Git</a> provides
-- 
1.5.3.4.206.g58ba4
