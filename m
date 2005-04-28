From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Merge with git-pasky II.
Date: Thu, 28 Apr 2005 02:42:55 +0200
Message-ID: <20050428004254.GX22956@pasky.ji.cz>
References: <Pine.LNX.4.44.0504261400570.4678-100000@wax.eds.org> <Pine.LNX.4.58.0504261522340.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bram Cohen <bram@bitconjurer.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQx2A-0000eD-0d
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVD1Am7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVD1Am7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:42:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44718 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262129AbVD1Am4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:42:56 -0400
Received: (qmail 2958 invoked by uid 2001); 28 Apr 2005 00:42:55 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504261522340.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 27, 2005 at 12:25:58AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Tue, 26 Apr 2005, Bram Cohen wrote:
> > 
> > So you think that a system which supports snapshots and history but has no
> > merging functionality whatsoever is the right thing?
> 
> You haven't looked at git, have you?
> 
> Git already merges better than _any_ open-source SCM out there. It just 
> does it so effortlessly that you didn't even realize it does that.

Did you (or any other kernel developer reading this) actually try the
Codeville merge? (I admit I didn't get time to do anything real with it
yet.) SCM people keep praising it (as basically the best (at least
open-source) merge out there), so it would be interesting to compare
that with the actual real-world experience with it on the kernel.

> Today I've done four (count them) fully automated merges on the kernel
> tree: serial, networking, usb and arm.
> 
> And they took a fraction of a second (plus the download of the new
> objects, which is the real cost).
> 
> This is something that SVN _still_ cannot do, for example. 

I think SVN is just irrelevant here - it is a completely different
league. The contenders here are probably Codeville, Monotone and perhaps
GNU Arch offsprings.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
