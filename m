From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 23:21:26 +0100
Message-ID: <20080111222126.GA30184@uranus.ravnborg.org>
References: <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de> <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de> <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org> <14E7B5D5-B1B8-4532-A471-106B14B912B8@zib.de> <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org> <20080111195022.GC29189@uranus.ravnborg.org> <alpine.LSU.1.00.0801112116180.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDSG5-0001CS-Ut
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761265AbYAKWVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 17:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761082AbYAKWVW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 17:21:22 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:60438 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761110AbYAKWVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 17:21:21 -0500
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 932A5E30D9C;
	Fri, 11 Jan 2008 23:21:20 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id 188AE580D2; Fri, 11 Jan 2008 23:21:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801112116180.31053@racer.site>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70217>

On Fri, Jan 11, 2008 at 09:18:49PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 11 Jan 2008, Sam Ravnborg wrote:
> 
> > On Fri, Jan 11, 2008 at 11:16:02AM -0800, Linus Torvalds wrote:
> > 
> > > (Every place I've ever been at, people who had a choice would never 
> > > ever develop under Windows, so I've never seen any real mixing - even 
> > > when some parts of the project were DOS/Windows stuff, there was a 
> > > clear boundary between the stuff that was actually done under Windows)
> > 
> > The reality I see is the other way around as common practice.
> 
> Not in my world.
> 
> I see a few people who are stuck to Windows, but they are so because they 
> are lazy.  They do not ever do something interesting with computers in 
> their free time, and while working, they only do what they are told to do.

Some of the people I have in my mind I will certainly not call lazy, but the
other part of the description is a fine match.

> That might sound cynical, but you will have to _show_ me different 
> examples to make me reconsider.

I just wanted to say that things looks different in some places of the
world nad for some types of development.
I do not even know what I should try to make you reconsider - as I did not
follow the full thread. Just stumbled over this statement.

	Sam
