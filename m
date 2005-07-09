From: Petr Baudis <pasky@suse.cz>
Subject: Re: Linus kernel tree corrupt?
Date: Sat, 9 Jul 2005 13:55:30 +0200
Message-ID: <20050709115530.GC26343@pasky.ji.cz>
References: <9e473391050708085756bd463e@mail.gmail.com> <12c511ca05070810065db87043@mail.gmail.com> <20050709114303.B2175@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 09 14:00:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrE0I-0002pk-Af
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 14:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVGIL74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 07:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVGIL4r
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 07:56:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21456 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261229AbVGILzc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2005 07:55:32 -0400
Received: (qmail 1386 invoked by uid 2001); 9 Jul 2005 11:55:30 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050709114303.B2175@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 09, 2005 at 12:43:03PM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> On Fri, Jul 08, 2005 at 10:06:09AM -0700, Tony Luck wrote:
> > On 7/8/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > What happened in this session...
> > 
> > Linus has "packed" his GIT tree ... and now http-pull doesn't work. 
> > rsync still does (provided
> > you have a new enough cogito).
> 
> So does that mean we should ignore cogito's whinging about rsync being
> deprecated?

Yes, please do. I deprecated rsync a day before Linus "broke" http-pull.
It's un-deprecated again for now in the latest Cogito.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
