From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 08/15] gitdiffcore(7): fix awkward wording
Date: Thu, 3 Jul 2008 00:30:25 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030028250.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Chris Shoemaker <c.shoemaker@cox.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7o-0002yW-MS
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbYGCG7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbYGCG6C
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:02 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:36740 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbYGCFaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:30:35 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635UPlk009817;
	Thu, 3 Jul 2008 00:30:25 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635UPad019027;
	Thu, 3 Jul 2008 00:30:25 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87250>

The phrase "diff outputs" sounds awkward to my ear (I think
"output" is meant to be used as a substantive noun.)

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/gitdiffcore.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 0b7daed..1171b5c 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -16,8 +16,8 @@ The diff commands `git-diff-index`, `git-diff-files`, and `git-diff-tree`
 can be told to manipulate differences they find in
 unconventional ways before showing `diff` output.  The manipulation
 is collectively called "diffcore transformation".  This short note
-describes what they are and how to use them to produce diff outputs
-that are easier to understand than the conventional kind.
+describes what they are and how to use them to produce diff output
+that is easier to understand than the conventional kind.
 
 
 The chain of operation
-- 
1.5.5.GIT
