From: Petr Baudis <pasky@suse.cz>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 16:40:40 +0200
Message-ID: <20080726144040.GZ32184@machine.or.cz>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com> <20080726015314.GU32184@machine.or.cz> <20080726020951.GV32184@machine.or.cz> <7v4p6dnv5k.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807260627480.26810@eeepc-johanness> <7vtzedmeqh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMkxr-0001d0-C6
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYGZOkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbYGZOkn
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:40:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53296 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbYGZOkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:40:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2DCBA393B321; Sat, 26 Jul 2008 16:40:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzedmeqh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90228>

On Fri, Jul 25, 2008 at 09:49:42PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 25 Jul 2008, Junio C Hamano wrote:
> >
> >> It's also somewhat interesting to observe that several people I have 
> >> never heard of in the git circle are simultaneously doing new git books, 
> >> apparently never asking for much technical advice from core git people, 
> >> by the way.

  I would say we actually worked hard to make itpossible to understand
Git without being a Git contributor and knowing the code inside-out,
didn't we? So in a sense, having books about Git written by people
outside of the developer community could be considered a certain
milestone for Git usability. At least provided the books are good, and
reading the excerpts from

	http://www.pragprog.com/titles/tsgit/pragmatic-version-control-using-git

has been a little disturbing experience at times. Then again, it is an
early alpha probably far before technical editing, so it is too early
to draw conclusions. (And after doing technical editing for a very thick
Czech book on low-level Linux programming, my standards for this phase
of book development had to be... somewhat lowered. ;-)

> Oh, mine was not a criticism but was just an observation.
> 
> Maybe the folks we consider as "git community members" are either too
> narrow, or too detached from the "real user community", and it could be
> that git books are better written without us.

  The numbers in another part of the thread show something important -
GitHub is more than SIX TIMES BIGGER than repo.or.cz! How many of you
have GitHub accounts, and how many of you are actively using repo.or.cz?
:-) And GitHub is not "just" Ruby on Rails *at all*:

	http://github.com/blog/99-popular-languages

Overally, it seems that Git is getting huge traction in the web
developers community while this is something I would presume the core
Git community of kernel hackers and such is mostly unaware of (and it is
somewhat amusing contrast). Now, these are people who we will probably
never see on the mailing list, not just because they frequently don't
even know C, and don't care to, but they might have actually never used
a mailing list before! These are the people who frequently could not
care about their VCS' internals less and finding out that Git works well
enough for them is something rather satisfying for me personally.

  I don't know if this should have any immediate effect on how we
develop Git etc., but I think it is good to be aware of the fact that
silently, huge amount of "dark mass" Git projects is accumulating and
that Git is making headways in areas many of us were little aware of.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
