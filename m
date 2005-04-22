From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [3/5] Add http-pull
Date: Sat, 23 Apr 2005 01:08:55 +0200
Message-ID: <20050422230855.GJ21204@pasky.ji.cz>
References: <20050422224008.GD21204@pasky.ji.cz> <Pine.LNX.4.21.0504221844420.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tony.luck@intel.com, Brad Roberts <braddr@puremagic.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7CH-0004LI-Ke
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDVXJC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDVXJC
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:09:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26274 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261285AbVDVXI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 19:08:56 -0400
Received: (qmail 28760 invoked by uid 2001); 22 Apr 2005 23:08:55 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504221844420.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 01:00:33AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Sat, 23 Apr 2005, Petr Baudis wrote:
> 
> > Dear diary, on Fri, Apr 22, 2005 at 09:46:35PM CEST, I got a letter
> > where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > 
> > Huh. Why? You just go back to history until you find a commit you
> > already have. If you did it the way as Tony described, if you have that
> > commit, you can be sure that you have everything it depends on too.
> 
> But if you download 1000 files of the 1010 you need, and then your network
> goes down, you will need to download those 1000 again when it comes back,
> because you can't save them unless you have the full history. 

Why can't I? I think I can do that perfectly fine. The worst thing that
can happen is that fsck-cache will complain a bit.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
