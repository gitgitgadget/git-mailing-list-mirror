From: Junio C Hamano <junkio@cox.net>
Subject: Re: git todo-list ?
Date: Mon, 23 Apr 2007 17:54:41 -0700
Message-ID: <7vslaqbnhq.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0704231544r53d1bfbej7ddee0c66d894f3c@mail.gmail.com>
	<7vlkgid7x4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 02:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9It-0002UM-Ap
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031005AbXDXAyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031006AbXDXAyo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:54:44 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53053 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031005AbXDXAym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:54:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424005442.NDRS1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 20:54:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qouh1W00L1kojtg0000000; Mon, 23 Apr 2007 20:54:41 -0400
In-Reply-To: <7vlkgid7x4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 23 Apr 2007 15:48:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45397>

Junio C Hamano <junkio@cox.net> writes:

> "Yakov Lerner" <iler.ml@gmail.com> writes:
>
>> Does git have todo-list ?
>
> We could start one with an entry:
>
> 	- create a initial set of to-do-list and find a
>           volunteer to maintain it.
>
> perhaps at wiki.or.cz/

Arrgh.  The url is http://git.or.cz/gitwiki

By the way, I see on that wiki that somebody attempted to have a
list of Wishlist (http://git.or.cz/gitwiki/Wishlist).  I think
many of them are now irrelevant, or stale, or have been
rejected.  It even includes tongue-in-cheek suggestions made as
counterarguments as if they are serious proposals.  I just have
done a minimum clean-up but many of them that I did not touch
are not necessarily there because I agree they are good
suggestions, but because I did not understand what they are
talking about.

As with any "tracking" list, wanting to have one and starting is
the easy part.  Unless kept up to date, such a list becomes
quickly useless, or even worse than not having one, leading to
wasted wild goose chase if people look at it without knowing how
stale it is.

And keeping any such list up-to-date takes a lot of effort.
Anybody who attempts it needs to have a lot of time and enough
knowledge to sift through both the list traffic to note not just
the initial issue-raising, but how the issues have been resolved
(or unresolved).  I sometimes do that and send out "Unresolved
issues" message to the list myself every once in a while, but as
the maintainer my attention tends to be more on the big-picture
issues and not minor details, and I do not think there are any
unresolved issue at the big-picture level that I haven't talked
about in recent "What's in / What's cooking" messages.
