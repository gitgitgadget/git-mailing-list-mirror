From: "Zorba" <cr@altmore.co.uk>
Subject: user manual question
Date: Sun, 28 Dec 2008 11:07:54 -0000
Message-ID: <gj7mmo$fvk$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 12:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGtXT-0003dH-DY
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 12:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYL1LIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 06:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYL1LIT
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 06:08:19 -0500
Received: from main.gmane.org ([80.91.229.2]:60781 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbYL1LIT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 06:08:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LGtVJ-00007X-64
	for git@vger.kernel.org; Sun, 28 Dec 2008 11:08:17 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 11:08:17 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 11:08:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104045>

Under "Examining an old version without creating a new branch" subsection in 
chapter1

to aid my understanding, could the statement:

"The HEAD then refers to the SHA1 of the commit instead of to a branch, and 
git branch shows that you are no longer on a branch:"

be restated more explicitly as:

"The HEAD then refers to the SHA1 of the commit instead of to a branch head, 
and git branch shows that you are no longer on a branch head:"

?
