From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] RelNotes-1.6.5: fix spelling of 'Mozilla'
Date: Tue, 22 Sep 2009 02:58:14 +0200
Message-ID: <20090922005814.GO32702@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 02:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpti3-0006yK-Ux
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 02:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbZIVA6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 20:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbZIVA6O
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 20:58:14 -0400
Received: from virgo.iok.hu ([212.40.97.103]:43536 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbZIVA6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 20:58:14 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D89DE5809A;
	Tue, 22 Sep 2009 02:58:16 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C06D644908;
	Tue, 22 Sep 2009 02:58:15 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 76A9E11F0028; Tue, 22 Sep 2009 02:58:15 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128915>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/RelNotes-1.6.5.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.6.5.txt b/Documentation/RelNotes-1.6.5.txt
index 25529f7..3c46192 100644
--- a/Documentation/RelNotes-1.6.5.txt
+++ b/Documentation/RelNotes-1.6.5.txt
@@ -46,7 +46,7 @@ Updates since v1.6.4
  * On major platforms, the system can be compiled to use with Linus's
    block-sha1 implementation of the SHA-1 hash algorithm, which
    outperforms the default fallback implementation we borrowed from
-   Mozzilla.
+   Mozilla.
 
  * Unnecessary inefficiency in deepening of a shallow repository has
    been removed.
-- 
1.6.4
