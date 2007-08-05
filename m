From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 5 Aug 2007 05:59:28 -0400
Message-ID: <20070805095928.GA15949@coredump.intra.peff.net>
References: <46B3F762.1050306@midwinter.com> <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com> <20070804091249.GA17821@uranus.ravnborg.org> <46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org> <85myx7dwb3.fsf@lola.goethe.zz> <20070805094247.GE12507@coredump.intra.peff.net> <85abt6b91w.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:59:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcta-0000ri-Nd
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbXHEJ7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbXHEJ7b
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:59:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4655 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbXHEJ7b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 05:59:31 -0400
Received: (qmail 16362 invoked from network); 5 Aug 2007 09:59:33 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 09:59:33 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 05:59:28 -0400
Content-Disposition: inline
In-Reply-To: <85abt6b91w.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54981>

On Sun, Aug 05, 2007 at 11:54:51AM +0200, David Kastrup wrote:

> >> (info "(gcc) Extended Asm")
> >> 
> >> and when you are reading mail in Emacs, you can click on that line
> >> and get to the respective page in a manual comprising hundreds of
> >> pages.
> >
> > Ugh. A documentation referencing system that works only in one
> > particular editor,
> 
> That works in readers of the info format.  Do HTML references work
> outside of HTML readers?

I'm not talking about the _format_, I'm talking about the _referencing
system_. In other words, because URLs are a standard, there are
thousands of programs which recognize them and can find the resource
they mention (which in turn, may spawn an info reader, an html reader,
or some other interpreter).

What software is going to recognize (info "(gcc) Extended Asm") in your
email and realize that it's a reference to another document? None,
except emacs.

Though I don't especially like the info format or readers, my argument
here isn't against it. It is against the feature you mentioned being a
substantial benefit, since a large part of the world isn't reading their
email in emacs.

-Peff
