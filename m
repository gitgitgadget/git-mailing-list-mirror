From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Fri, 25 Jul 2008 21:09:43 -0700
Message-ID: <7v4p6dnv5k.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
 <20080726015314.GU32184@machine.or.cz> <20080726020951.GV32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 26 06:10:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMb7O-0001hL-R6
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 06:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbYGZEJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 00:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbYGZEJy
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 00:09:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYGZEJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 00:09:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF742431E6;
	Sat, 26 Jul 2008 00:09:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C524431E2; Sat, 26 Jul 2008 00:09:45 -0400 (EDT)
In-Reply-To: <20080726020951.GV32184@machine.or.cz> (Petr Baudis's message of
 "Sat, 26 Jul 2008 04:09:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0F35374-5AC8-11DD-8F30-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90167>

Petr Baudis <pasky@suse.cz> writes:

> .... Of course, I would be transferring the control of the homepage
> from my hands so I would like to poll the community about how do people
> feel about this - opinion of core Git contributors would be especially
> welcome...
> ...
>   - The new site is affiliated with a commercial entity - GitHub.
> The website maintainer also has commercial interest in some published
> Git learning materials, which might generate certain conflict of
> interests; we must trust them that they handle this well.
>   - Both GitHub and Scott seem to be rather distanced from the "core"
> Git development community. This might or might not be an issue.

These two are directly related.  They might be friendly and well-meaning
folks, but I agree that they haven't earned our trust yet.

But I do not think it matters that much.

The thing is, git.or.cz may have been the closest thing to the "official"
homepage we have had, but that is not because Linus or I or Shawn declared
the site is official and/or that the site is trustworthy.  It was because
you put efforts preparing the contents worthy to be one-stop shop for git
related information, back when there was no such thing.  And the members
of the comminity found it a good site.  And you have the wiki there, where
there truly have been community participation to enhance the contents.

For me personally, pages outside the wiki have never felt like "the
official git homepage", not because the contents you prepared were
inadequate, but because I did not see much community participation to help
enrich it.

So I wish the new site success, but the definition of success from my
point of view is not how many random visitors it will attract, but how
well the site makes the contributors (both to git software itself, and to
the site's contents) feel welcomed.  Maybe in time it will become
successful enough by _my_ definition of success, and I may recommend
kernel.org folks to point at it from http://git.kernel.org/ (link with
text "overview") if/when that happens, and I may start mentioning them in
the "Note".  We'll see.

>   The negatives section writeup is longer, but in fact I think the
> positives win here; I also have a bit of bad conscience about not giving
> git.or.cz the amount of time it would deserve...

Let me thank you for maintaining not just git.or.cz/ but also repo.or.cz/
and the wiki.  I personally never visited the "Homepage" but the
repositories and the wiki are valuable services you gave back to the
community.

It's also somewhat interesting to observe that several people I have never
heard of in the git circle are simultaneously doing new git books,
apparently never asking for much technical advice from core git people, by
the way.
