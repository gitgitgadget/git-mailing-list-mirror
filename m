From: Brian Gernhardt <benabik@silverinsanity.com>
Subject: Commit message for 1240f94 has mail headers
Date: Sun, 6 Jul 2008 04:00:23 -0400
Message-ID: <2C6B8E28-3E8A-414E-9DB7-626E9709C831@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 10:29:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFPd3-0002sU-Jf
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 10:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbYGFI2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 04:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYGFI2M
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 04:28:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43581 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYGFI2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 04:28:11 -0400
X-Greylist: delayed 1665 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jul 2008 04:28:11 EDT
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C9F041FFC021
	for <git@vger.kernel.org>; Sun,  6 Jul 2008 08:00:11 +0000 (UTC)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87505>

The commit message for 1240f94 (next~2^2~1 in my repo) reads as follows:

----- 8< -----
     Add new test case to ensure git-merge prepends the custom merge  
message

     7b9b8a456462c83.1214581610.git.vmiklos@frugalware.org>
     In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
     References: <cover.1214581610.git.vmiklos@frugalware.org>
     X-Pobox-Pass: vmiklos@frugalware.org is whitelisted
     X-ICG-Account-ID: 77302942
     Xref: gitster.siamese.dyndns.org git-review:1871
     Lines: 55

     There was no test for this before, so the testsuite passed, even  
in case
     the merge summary was missing from the merge commit message.

     Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>
----- 8< -----

I don't think all those mail headers are supposed to be in there.  I  
don't know if it's too late to fix that, but I thought you should know.

~~ Brian
