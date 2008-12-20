From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] SubmittingPatches: mention the usage of real name in Signed-off-by: lines
Date: Sat, 20 Dec 2008 01:52:17 +0100
Message-ID: <1229734337-14853-1-git-send-email-vmiklos@frugalware.org>
References: <7vbpv765oc.fsf@gitster.siamese.dyndns.org>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 01:51:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDq4P-0002Fe-Q6
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 01:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbYLTAuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 19:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYLTAuf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 19:50:35 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49209 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbYLTAuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 19:50:35 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 9ADE8446CDE;
	Sat, 20 Dec 2008 01:50:33 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 28DBB19DBE1; Sat, 20 Dec 2008 01:52:17 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.35.gae26e.dirty
In-Reply-To: <7vbpv765oc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103614>

Especially with something that is supposed to hopefully have some legal
value down the line if somebody starts making noises, it really would be
nice to have a real person to associate things with. Suggest this in the
SubmittingPatches document.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Dec 19, 2008 at 04:39:31PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> I would agree with the reasoning, but do we have to say "childish"
> just to
> be derogatory?  I think that is counterproductive.

True.

 Documentation/SubmittingPatches |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f0295c6..ba07c8c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -222,6 +222,9 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
+Also notice that a real name is used in the Signed-off-by: line. Please
+don't hide your real name.
+
 Some people also put extra tags at the end.
 
 "Acked-by:" says that the patch was reviewed by the person who
-- 
1.6.1.rc1.35.gae26e.dirty
