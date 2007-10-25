From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 14:16:42 -0400
Message-ID: <20071025181642.GC31888@fieldses.org>
References: <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <1193328386.4522.352.camel@cacharro.xalalinux.org> <20071025163835.GB31888@fieldses.org> <1193335562.4522.403.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7GP-0002Y2-Ca
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbXJYSQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbXJYSQp
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:16:45 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47953 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbXJYSQo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:16:44 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Il7G7-0004hV-1G; Thu, 25 Oct 2007 14:16:43 -0400
Content-Disposition: inline
In-Reply-To: <1193335562.4522.403.camel@cacharro.xalalinux.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62344>

On Thu, Oct 25, 2007 at 01:06:02PM -0500, Federico Mena Quintero wrote:
> On Thu, 2007-10-25 at 12:38 -0400, J. Bruce Fields wrote:
> 
> > It's definitely not a simple cut-and-paste--even with permission from
> > the author of "Git for computer scientists", fitting this in would
> > require rethinking the ordering of topics in the manual.
> 
> Oh, that can be done.  It's easier to move text around than to
> rearchitect code :)

OK!  I'm happy to help review patches, etc.

> > Also, there's
> > the restriction that we'd like to keep it looking good in plain ascii,
> > so diagrams have to be done in ascii somehow.
> 
> Hmm, what's the rationale for this?

There have always been a lot of complaints about the difficulty of
building the documentation.  (I don't know why; at least on Debian all
you need is an "apt-get build-dep git-core".)  And our response has been
"no problem, you can just read the source."  That's a big reason why
asciidoc was chosen.

> I'd assume that most people read the user's manual as a web page (or
> as bedside reading if they can print a PDF thereof), where diagrams
> can be pretty.

Yeah.  Heck, I just read it by pointing my web browser at kernel.org's
html copy....

So you might get some sympathy for a request for fancier diagrams, I
don't know.  It would require some more discussion, so I'd rather not
have other improvements blocked by this.

--b.
