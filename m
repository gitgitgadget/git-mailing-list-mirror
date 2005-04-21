From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Docs update
Date: Thu, 21 Apr 2005 23:26:02 +0200
Message-ID: <20050421212602.GL7443@pasky.ji.cz>
References: <42680FCC.6030901@dgreaves.com> <20050421204348.GJ7443@pasky.ji.cz> <4268181B.6050906@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:23:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOj7I-0007MN-A7
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVDUV0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 17:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVDUV0G
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 17:26:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50312 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261886AbVDUV0D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 17:26:03 -0400
Received: (qmail 23908 invoked by uid 2001); 21 Apr 2005 21:26:02 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4268181B.6050906@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 11:16:11PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Petr Baudis wrote:
> >
> >Make a choice - either you are describing git or Cogito. The frmer has
> >no RSYNC_FLAGS and does not care about any heads or anything at all (you
> >might mention it as a recommended convention, though).
> 
> I was going to do both - surely that's OK?

I thought the original goal for README.reference was to be git-specific,
and I planned to therefore push it to the core git at some point.

I actually probably don't mind as long as you keep the two separated
cleanly inside of the file, so if we shall want to include it in git,
the trimming of the docs to only relevant parts is simple enough.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
