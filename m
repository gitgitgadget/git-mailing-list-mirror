From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk "parent information" in commit window
Date: Mon, 8 Aug 2005 08:52:36 +1000
Message-ID: <17142.37044.108962.189983@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 08 00:55:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1u2S-00047a-Oz
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 00:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbVHGWyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 18:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbVHGWyf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 18:54:35 -0400
Received: from ozlabs.org ([203.10.76.45]:54485 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752174AbVHGWye (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2005 18:54:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BF0B867F31; Mon,  8 Aug 2005 08:54:33 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> This adds a useful "Parent:" line to the git commit information window.

Cool!  Applied and pushed out.

I have been thinking about adding dialog windows to allow the user to
select which repository and which range of commits they want to look at.
Do you think that would be useful for you?

Regards,
Paul.
