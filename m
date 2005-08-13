From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 2/5] Add SEE ALSO section to cogito(7) which mentions git(7)
Date: Sat, 13 Aug 2005 18:25:48 +0200
Message-ID: <20050813162548.GC968@diku.dk>
References: <20050813162352.GA968@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:26:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ypU-0000Ke-55
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVHMQZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVHMQZu
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:25:50 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:17882 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932180AbVHMQZt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:25:49 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 7B7266E1489; Sat, 13 Aug 2005 18:25:36 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 454766E13FD; Sat, 13 Aug 2005 18:25:36 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 61F6D60A44; Sat, 13 Aug 2005 18:25:48 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050813162352.GA968@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/make-cogito-asciidoc |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -157,4 +157,8 @@ FILES
 COPYRIGHT
 ---------
 Copyright (C) Petr Baudis, 2005.
+
+SEE ALSO
+--------
+Cogito is based on gitlink:git[7].
 __END__

-- 
Jonas Fonseca
