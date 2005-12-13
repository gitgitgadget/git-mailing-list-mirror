From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.16.1
Date: Tue, 13 Dec 2005 23:31:14 +0100
Message-ID: <20051213223114.GF22159@pasky.or.cz>
References: <20051212011210.GC12373@pasky.or.cz> <20051212182636.d3b73900.paul@permanentmail.com> <20051213165645.GC22159@pasky.or.cz> <20051213110257.a37be18b.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 23:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIgQ-0006dV-4Q
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVLMWbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVLMWbR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:31:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60589 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030299AbVLMWbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:31:16 -0500
Received: (qmail 2828 invoked by uid 2001); 13 Dec 2005 23:31:14 +0100
To: Paul Dickson <paul@permanentmail.com>
Content-Disposition: inline
In-Reply-To: <20051213110257.a37be18b.paul@permanentmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13604>

Dear diary, on Tue, Dec 13, 2005 at 07:02:57PM CET, I got a letter
where Paul Dickson <paul@permanentmail.com> said that...
> On Tue, 13 Dec 2005 17:56:45 +0100, Petr Baudis wrote:
> 
> > Dear diary, on Tue, Dec 13, 2005 at 02:26:36AM CET, I got a letter
> > where Paul Dickson <paul@permanentmail.com> said that...
> > > Any chance of man files?  I'm more use to type man than cg-help.
> > 
> > You can make the man files by
> > 
> > 	make doc
> > 
> > and install them by
> > 
> > 	make install-doc
> > 
> > 
> > This isn't done by default so that you won't need asciidoc for the
> > build. This is exactly the same way in GIT.
> 
> See my messages about 0.99.9m and xmlto (and asciidoc).  They are
> currently required for building the RPMs.  Perhaps the spec file needs
> updating.

But the spec file also makes the 'doc' and 'install-doc' targets. When
you act as a packager, asciidoc becomes a reasonable build-time
requirement.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
