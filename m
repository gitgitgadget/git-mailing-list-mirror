From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHES] CURLDIR support, more usable cmd-rename.sh
Date: Mon, 19 Sep 2005 15:37:31 +0200
Message-ID: <20050919133731.GB2903@pasky.or.cz>
References: <1127128475.781.6.camel@divert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 15:39:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHLq4-0001dw-AZ
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 15:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVISNhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 09:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVISNhe
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 09:37:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1712 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932379AbVISNhe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 09:37:34 -0400
Received: (qmail 8566 invoked by uid 2001); 19 Sep 2005 15:37:32 +0200
To: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Content-Disposition: inline
In-Reply-To: <1127128475.781.6.camel@divert>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8859>

Dear diary, on Mon, Sep 19, 2005 at 01:14:36PM CEST, I got a letter
where Patrick Mauritz <oxygene@studentenbude.ath.cx> told me that...
> hello,

Hello,

> attached are two patches.

seems that they didn't quite get attached in the end. ;-)

> another issue I had was that mailinfo uses strcasestr, which isn't in
> solaris' libc (and not in posix according to
> http://lists.gnu.org/archive/html/bug-gnulib/2005-08/msg00076.html). I
> disabled it in my build for now, and might come up with a patch later,
> unless someone beats me to it.

Linus already did in <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
