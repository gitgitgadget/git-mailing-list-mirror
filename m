From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Mon, 03 Dec 2007 10:09:01 +0100
Message-ID: <4753C7AD.3000406@op5.se>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>	<7voddl24b7.fsf@gitster.siamese.dyndns.org>	<47464A90.4030509@catalyst.net.nz> <7vhcj387jh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org,
	francois@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 10:09:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz7Iy-0002H7-Bv
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 10:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXLCJJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 04:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbXLCJJK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 04:09:10 -0500
Received: from mail.op5.se ([193.201.96.20]:47349 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbXLCJJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 04:09:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2053C1F08012;
	Mon,  3 Dec 2007 10:09:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4LKCJSxNEd9; Mon,  3 Dec 2007 10:09:06 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 0F2E41F0800F;
	Mon,  3 Dec 2007 10:09:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vhcj387jh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66892>

Junio C Hamano wrote:
> 
> [Footnote]
> 
> *1* git(7) calls "git" itself as "git potty".  Is this word still used?
> I also notice that Andreas's name is misspelled there.


AFAIR I sort of invented that to disambiguate git-the-program from
git-the-project while working on writing the program in C. I haven't
heard/seen it a lot since then, except on a few occasions where it
helped serve that same purpose.

I also misspelled my own name in that patch. Perhaps it's time I
corrected that.

---%<---%<---%<---
From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] Correct typo in Documentation/git.txt

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9ff4659..6c98ab2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -536,7 +536,7 @@ Authors
 -------
 * git's founding father is Linus Torvalds <torvalds@osdl.org>.
 * The current git nurse is Junio C Hamano <gitster@pobox.com>.
-* The git potty was written by Andres Ericsson <ae@op5.se>.
+* The git potty was written by Andreas Ericsson <ae@op5.se>.
 * General upbringing is handled by the git-list <git@vger.kernel.org>.
 
 Documentation
---%<---%<---%<---
-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
