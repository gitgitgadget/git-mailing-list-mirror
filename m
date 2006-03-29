From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Support for pickaxe matching regular expressions
Date: Wed, 29 Mar 2006 15:09:20 +0200
Message-ID: <20060329130920.GH27689@pasky.or.cz>
References: <15693.1143575188@lotus.CS.Berkeley.EDU> <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.63.0603291340570.1473@wbgn013.biozentrum.uni-wuerzburg.de> <15693.1143575188@lotus.CS.Berkeley.EDU> <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603281500280.15714@g5.osdl.org> <20060329001633.GF27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 15:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOaQH-0001pE-So
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 15:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWC2NJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 08:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWC2NJM
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 08:09:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:22765 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750728AbWC2NJL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 08:09:11 -0500
Received: (qmail 15409 invoked by uid 2001); 29 Mar 2006 15:09:20 +0200
To: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0603291340570.1473@wbgn013.biozentrum.uni-wuerzburg.de> <20060329001633.GF27689@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18167>

Dear diary, on Wed, Mar 29, 2006 at 02:16:33AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> The regex.h library is a rather stupid interface and I like pcre too, but
> with any luck it will be everywhere we will want to run Git on, it being
> POSIX.2 and all. I'm not sure if we can expect platforms like AIX to
> conform to POSIX.2 or if win32 has regex.h. We might add a flag to
> Makefile if there is a portability trouble potential.

Dear diary, on Wed, Mar 29, 2006 at 01:42:00PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> We already use regex.h (probably my fault).

Indeed, and since noone complained yet, the portability consideration is
apparently a non-issue.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
