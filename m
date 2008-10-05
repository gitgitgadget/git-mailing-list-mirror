From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: gitweb improvements
Date: Sun, 5 Oct 2008 17:45:01 +0200
Message-ID: <00a201c92701$54ec6980$fec53c80$@se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 17:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmVvQ-0003K3-96
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 17:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbYJEPwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 11:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754310AbYJEPwP
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 11:52:15 -0400
Received: from csmtp2.b-one.net ([195.47.247.206]:47636 "EHLO csmtp2.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048AbYJEPwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 11:52:15 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Oct 2008 11:52:15 EDT
Received: from jockexp (84-217-5-146.tn.glocalnet.net [84.217.5.146])
	by csmtp2.b-one.net (Postfix) with ESMTP id D3D6516001428
	for <git@vger.kernel.org>; Sun,  5 Oct 2008 17:45:41 +0200 (CEST)
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcknAVQF7lxhQhZjRg2aDKnAU2Mr5A==
Content-Language: sv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97512>

When I browse a repo using gitweb, I miss two things:
1) looking at the history for a file or directory I really want
   to see the tags there too.

2) looking at a merge like:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=66120005e65eed8a05b14a36ab448bdec42f0d6b
   is somewhat confusing. It really doesn't tell you which commits that is
   included in the merge.

 Jocke
