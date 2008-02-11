From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Applying patches from gmane can be dangerous.
Date: Mon, 11 Feb 2008 21:16:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802112115590.3870@racer.site>
References: <20080205211044.GP26392@lavos.net> <7vodatqu6w.fsf@gitster.siamese.dyndns.org> <20080207133208.GT26392@lavos.net> <20080207145036.GM26016@yugib.highrise.ca> <alpine.LSU.1.00.0802071605540.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Magne Ingebrigtsen <larsi+gmane@gnus.org>,
	Abdelrazak Younes <younes.a@free.fr>
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOg1n-0000VP-0V
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYBKVQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbYBKVQw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:16:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:41013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbYBKVQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:16:51 -0500
Received: (qmail invoked by alias); 11 Feb 2008 21:16:49 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp018) with SMTP; 11 Feb 2008 22:16:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185fzRJ1Eg5D6hsoUA/2Pk0CmHQxIU7zuZKN/2uPY
	qTrvjuEDw3KNU3
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802071605540.8543@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73585>

Hi,

On Thu, 7 Feb 2008, Johannes Schindelin wrote:

> On Thu, 7 Feb 2008, Aidan Van Dyk wrote:
> 
> > * Brian Downing <bdowning@lavos.net> [080207 07:32]:
> > > On Wed, Feb 06, 2008 at 08:14:31PM -0800, Junio C Hamano wrote:
> > > > This is really sad.  gmane gives us a clean threaded interface
> > > > (both in web and newsreader), and it never forgets. Whenever I
> > > > need to refer somebody to an old discussion, I can give an URL
> > > > to it and allmost all the discussion messages are there with a
> > > > single paste and clicking around.  It has been an indispensable
> > > > service to me ever since I started reading the git list with it.
> > > > It is really a shame that I have to prevent picking up patch
> > > > messages from it with the above hook.
> > > > 
> > > > I am wondering if other development communities had a similar
> > > > issue already, and if so how they are dealing with it.
> > > 
> > > Gmane didn't start doing this until recently.  Maybe they can stop it on
> > > a group-by-group basis?  Every post to git@vger is archived elsewhere
> > > with unmangled email addresses anyway...
> > > 
> > > "We understand why you're doing this, but it hurts us greatly.  Please
> > > stop."
> > 
> > Gmane has always done the "hide the real email" address on groups that
> > request it.  The git group does *not* request it, but the msysgit group
> > *has* requested it.
> 
> I just requested this setting to be changed.  Will keep you posted.

Okay, this took a while, basically, because I am not registered as a "list 
admin" at gmane.

But Abdel, who is, sorted out the problems, and we will no longer have 
this issue.

Thanks for your attention,
Dscho
