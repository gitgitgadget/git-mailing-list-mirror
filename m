From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Fri, 22 Apr 2005 12:37:37 +0200
Message-ID: <20050422103737.GC14565@pasky.ji.cz>
References: <20050422030931.GA14565@pasky.ji.cz> <20050422071626.GB8467@ip68-225-251-162.oc.oc.cox.net> <20050422072437.GC8467@ip68-225-251-162.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 12:34:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOvTH-0004yA-8G
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 12:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDVKho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 06:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVDVKho
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 06:37:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31126 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261212AbVDVKhj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 06:37:39 -0400
Received: (qmail 4854 invoked by uid 2001); 22 Apr 2005 10:37:37 -0000
To: "Barry K. Nathan" <barryn@pobox.com>
Content-Disposition: inline
In-Reply-To: <20050422072437.GC8467@ip68-225-251-162.oc.oc.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 09:24:37AM CEST, I got a letter
where "Barry K. Nathan" <barryn@pobox.com> told me that...
> On Fri, Apr 22, 2005 at 12:16:26AM -0700, Barry K. Nathan wrote:
> > With git-pasky 0.6.3, "git log" is unusable on my Mandrake 10.1 system.
> > Basically I get a neverending flood of these until I press 'q' to quit
> > less:
> [snip sed segmentation faults which happen with 0.6.3 but not 0.6.2]
> > I'm not sure if I have time tonight (or tomorrow) to troubleshoot this
> > further, but I'll see if I can.
> 
> I had sed-4.1.1-2mdk. I downloaded sed-4.1.4-2mdk (from Mandriva 2005
> Limited Edition) and updated to that, and the problem went away.
> 
> FWIW this is the second package I've had to update to the Mandriva 2005
> LE level (the first was mktemp). I don't mind however.

Duh, segfaulting sed! Could you please check which of the sed
invocations actually segfault for you?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
