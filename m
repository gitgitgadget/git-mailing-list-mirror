From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 19:42:02 +0100
Message-ID: <20051111184202.GA13524@steel.home>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de> <81b0412b0511110443x48415032k8ca40d999071e8a9@mail.gmail.com> <437494B2.30309@hogyros.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 19:45:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eadqu-00072M-6y
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 19:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVKKSmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 13:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbVKKSmR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 13:42:17 -0500
Received: from devrace.com ([198.63.210.113]:61712 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751002AbVKKSmQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 13:42:16 -0500
Received: from tigra.home (p54A0D6F6.dip.t-dialin.net [84.160.214.246])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jABIg4JD028920;
	Fri, 11 Nov 2005 12:42:06 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Eadqd-0000EA-00; Fri, 11 Nov 2005 19:42:03 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Eadqc-0003WR-Et; Fri, 11 Nov 2005 19:42:02 +0100
To: Simon Richter <Simon.Richter@hogyros.de>
Content-Disposition: inline
In-Reply-To: <437494B2.30309@hogyros.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.7 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11626>

Simon Richter, Fri, Nov 11, 2005 13:55:14 +0100:
> >But you shouldn't care if you have reasonably recent git everywhere:
> >symlinks and their absence already handled:
> 
> Well, I don't have working directories on USB sticks, so I don't 
> actually use the symlinks, would they be there, but I'm definitely 
> annoyed by not being able to copy a .git directory from some project 
> over and be done with it.
> 

Reasonable, perhaps. But are the git-pull and -clone _that_ slow or
awkward? Besides, you'd probably end up copying more than you'd want.

That's interesting case, btw. I'm restoring git mailing list in cc, so
it gets a bit wider of auditorium.
