From: Petr Baudis <pasky@suse.cz>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 13:41:05 +0200
Message-ID: <20060727114105.GZ13776@pasky.or.cz>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 13:41:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G64Ez-00011U-Ik
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 13:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWG0LlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 07:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWG0LlI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 07:41:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50152 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750720AbWG0LlG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 07:41:06 -0400
Received: (qmail 7928 invoked by uid 2001); 27 Jul 2006 13:41:05 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24279>

Dear diary, on Wed, Jul 26, 2006 at 11:36:16PM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> Can the library version of git be licensed LGPL instead of GPL? If it
> is GPL then it can't be linked into non-GPL projects like Eclipse.

Probably not since it essentially _is_ the base Git code now. You would
need to find all the Git copyright holders and convince them to
relicence it, since there are thoughts about moving more code to the
library, and even parts of scripts might eventually end up there after
rewrite in C.

And I didn't even get to discussing whether LGPL is actually desirable
for Git.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
