From: "Neal Kreitzinger" <neal@rsss.com>
Subject: gitk show only all refs matching pattern
Date: Fri, 2 Dec 2011 18:02:26 -0600
Message-ID: <jbbouj$p2$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 01:02:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWd4E-00057v-RF
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 01:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab1LCACu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 19:02:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:35216 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab1LCACt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 19:02:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RWd3v-0004vm-8g
	for git@vger.kernel.org; Sat, 03 Dec 2011 01:02:39 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Dec 2011 01:02:39 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Dec 2011 01:02:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186245>

Is there a way to tell gitk to show only all refs matching a pattern (e.g., 
all refs matching refs/heads/neal/*)?  (I'm using git 1.7.1)

v/r,
neal 
