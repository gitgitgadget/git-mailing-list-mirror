From: Petr Baudis <pasky@suse.cz>
Subject: Re: GitWiki lost ability to parse macros
Date: Thu, 7 Sep 2006 03:42:06 +0200
Message-ID: <20060907014206.GN18896@pasky.or.cz>
References: <edm7h3$nij$1@sea.gmane.org> <20060906113052.GC23891@pasky.or.cz> <edmcd6$9or$1@sea.gmane.org> <Pine.LNX.4.64.0609061712410.7168@reaper.quantumfyre.co.uk> <edmvsn$lt7$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 03:42:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL8uD-0001R6-Kv
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 03:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422629AbWIGBmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 21:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422630AbWIGBmJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 21:42:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3253 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422629AbWIGBmI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 21:42:08 -0400
Received: (qmail 18128 invoked by uid 2001); 7 Sep 2006 03:42:06 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <edmvsn$lt7$3@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26585>

Dear diary, on Wed, Sep 06, 2006 at 07:18:37PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Julian Phillips wrote:
> 
> > On Wed, 6 Sep 2006, Jakub Narebski wrote:
> > 
> >> Hmm... I still get for http://git.or.cz/gitwiki/RecentChanges
> >>
> >> {{RandomQuote()}}
> >>
> >> {{RecentChanges}}
> >>
> >>
> > 
> > MoinMoin caches a copy of the generated html page, which is automatically 
> > updated when you edit the page.  Since fixing the macros doesn't mean 
> > updating the page you have to manually delete the cache - this can be done 
> > from the "More Actions:" list.
> 
> Could admin of GitWiki then delete cache of all files?

I did that originally, but it looks like I've missed some bit. Hopefully
now all is in order. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
