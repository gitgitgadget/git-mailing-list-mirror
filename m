From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: workflow question
Date: Tue, 24 Jul 2007 17:00:24 -0400
Message-ID: <20070724210024.GC5040@fieldses.org>
References: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com> <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com> <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com> <20070724205702.GD6004@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Doyle <wpdster@gmail.com>, git <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDRUc-0003eV-PV
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759815AbXGXVA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXGXVA0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:00:26 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34254 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757760AbXGXVA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 17:00:26 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IDRUW-000438-6O; Tue, 24 Jul 2007 17:00:24 -0400
Content-Disposition: inline
In-Reply-To: <20070724205702.GD6004@steel.home>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53645>

On Tue, Jul 24, 2007 at 10:57:02PM +0200, Alex Riesen wrote:
> Patrick Doyle, Tue, Jul 24, 2007 18:30:12 +0200:
> > And, as for gitk, there is something about the combination of the
> > screen on my laptop, my Linux installation (FC6), my X server
> > configuration, and/or me that makes the fonts totally unreadable.  I
> > keep meaning to follow up on that, but I'm stuck in a
> > chicken-and-the-egg situation.  I don't see the utility of gitk
> > because I can't read the display that it produces.  I don't look for
> > the time to fix the display that it produces because, thus far, I
> > don't see the utility of gitk.  Sigh...
> 
> That's a real pity, because it is very powerful.
> 
> Try removing ~/.gitk, or look into it and try changing the font.

(Also, as a quick fix, note that ctrl-- and ctrl-= will adjust the font
size down or up (respectively).)

--b.
