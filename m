From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-clean, cg-status improvements
Date: Wed, 15 Feb 2006 00:02:37 +0100
Message-ID: <20060214230237.GL31278@pasky.or.cz>
References: <1139930899.1944.13.camel@dv> <20060214155356.GB9573@pasky.or.cz> <1139941032.26723.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 00:02:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F99BX-0008OL-CK
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 00:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422865AbWBNXBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 18:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWBNXBv
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 18:01:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37018 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422865AbWBNXBu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 18:01:50 -0500
Received: (qmail 24325 invoked by uid 2001); 15 Feb 2006 00:02:37 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1139941032.26723.4.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16191>

Dear diary, on Tue, Feb 14, 2006 at 07:17:12PM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> On Tue, 2006-02-14 at 16:53 +0100, Petr Baudis wrote:
> >   I didn't plan to require git 1.2.0 with 0.17, so it would be better if
> > you could do the workaround. But if the workaround means significant
> > hassle, it's no biggie if git 1.2.0 will be required.
> 
> It turns out a proper workaround can only be implemented in cg-Xlib, not
> in cg-clean.  It's a bit hairy for my taste (a bash guru could write it
> better, I believe), but it's a compact blob of code that can be easily
> removed at any time.

Wow, how you managed to simplify and shrink cg-clean sounds really
impressive! :)

Thanks, both applied and pushed out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
