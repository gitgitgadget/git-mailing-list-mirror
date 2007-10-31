From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 13:07:51 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710311305290.16298@ds9.cixit.se>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
 <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
 <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710310227340.4362@racer.site>
 <Pine.LNX.4.62.0710311048450.13264@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710311059020.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InCMt-0007IP-3H
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 13:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbXJaMIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 08:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbXJaMID
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 08:08:03 -0400
Received: from ds9.cixit.se ([193.15.169.228]:44255 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbXJaMIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 08:08:01 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9VC7qnQ019285
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 31 Oct 2007 13:07:52 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9VC7p7W019275;
	Wed, 31 Oct 2007 13:07:51 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <Pine.LNX.4.64.0710311059020.4362@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Wed, 31 Oct 2007 13:07:52 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62801>

> Yes!  Of course!  If what you want becomes possible, I could make an
> evil change in history long gone, and slip it by you. You could not
> even see the history which changed.

I would see the grafts file being changed, which would alert me (the
problem I have with graft is that it *replaces* history information for
an element, not just *add* to it, which threw me off at my first
attempt at creating one).

> You can do that already.  But you have to ask the people at the other
> end to actually apply the graft.

Last time I tried, git would not add files that was in the ".git"
subdirectory to version control. I might have done something
incorrectly, though, so I'll see if it works now.

> If you really think that, I doubt you understood the issues at hand.

I have, I'm just thinking of the issues that are created by solving the
issues it does solve.

-- 
\\// Peter - http://www.softwolves.pp.se/
