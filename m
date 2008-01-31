From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git rev-parse manpage: spelling fix
Date: Thu, 31 Jan 2008 20:55:57 +0100
Message-ID: <20080131195557.GB25954@genesis.frugalware.org>
References: <87myqoxvzk.fsf@rho.meyering.net> <20080130204357.GC4475@genesis.frugalware.org> <87ir1brq10.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKfWr-0001km-As
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 20:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbYAaT4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 14:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbYAaT4W
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 14:56:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39034 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618AbYAaT4V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 14:56:21 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JKfW1-00007t-Og
	from <vmiklos@frugalware.org>; Thu, 31 Jan 2008 20:56:19 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 64203119051B; Thu, 31 Jan 2008 20:55:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ir1brq10.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0087]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72136>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Jan 30, 2008 at 09:56:27PM +0100, Jim Meyering <jim@meyering.net> wrote:
> Send a patch.

here it is.

 Documentation/git-rev-parse.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index af98882..f02f6bb 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -234,8 +234,8 @@ blobs contained in a commit.
   (typically the current branch), and stage 3 is the version from
   the branch being merged.
 
-Here is an illustration, by Jon Loeliger.  Both node B and C are
-commit parents of commit node A.  Parent commits are ordered
+Here is an illustration, by Jon Loeliger.  Both commit nodes B
+and C are parents of commit node A.  Parent commits are ordered
 left-to-right.
 
     G   H   I   J
-- 
1.5.4.rc5-dirty
