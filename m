From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 15:51:39 +0200
Message-ID: <87a9aktqms.fsf@fencepost.gnu.org>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
	<xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
	<536ad9601b73b_3caaa612ecdc@nysa.notmuch>
	<CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
	<xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
	<CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
	<87mweku2pt.fsf@fencepost.gnu.org>
	<CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
	<87iop8u1km.fsf@fencepost.gnu.org>
	<CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
	<87egzwtthf.fsf@fencepost.gnu.org>
	<CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 15:51:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkZbA-0004Iq-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 15:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbaENNvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 09:51:53 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:45537 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801AbaENNvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 09:51:52 -0400
Received: from localhost ([127.0.0.1]:44578 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WkZb4-000335-F5; Wed, 14 May 2014 09:51:51 -0400
Received: by lola (Postfix, from userid 1000)
	id 8F3F1E05FE; Wed, 14 May 2014 15:51:39 +0200 (CEST)
In-Reply-To: <CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
	(Philippe Vaucher's message of "Wed, 14 May 2014 15:13:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248916>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

> I'm sorry that my words aren't clear enough for you to infer the point
> I'm trying to make. Let's try something simpler: what I was saying is
> that bad behavior will get you into trouble when contributing (and
> thus it's important to behave nicely), where Felipe usualy says bad
> behavior is irrelevant because only truth/quality is important.

Do you feel Felipe is in control of what you label bad behavior?  Do you
feel you are in control over how you react to his behavior?

> Yes it's unfortunate. The amount of talent in our societies that is
> wasted because of communication problems is probably quite high. I
> didn't find a way around "being social" in any human based community
> yet, but if you have an idea please share.

"being social" as an isolated feat is self-contradictory.  The question
is how to function in a particular social context.  Stock answers apply
to stock behaviors and are obviously most efficient to apply.

Yesterday my girl friend bought back a mare she had sold two years ago
because its owner did not manage to get along with it.  It's a
temperamental animal that learns and performs amazingly well for its
comparatively compact build.  But it's highest in rank "or else", and so
in the end it got locked up in its stable box most of the time in order
to avoid injuries to other horses.  Now it's back here at the riding
school, and there is little question that there will be some injuries
before things settle down again even though most of the horses here know
it already.

> The only way I can see working is that for someone to act as a
> mediator between the grumpy contributor and the community, but the
> role of this person is not very pleasant. That or maybe have merges
> done by some kind of robot with some AI about patch quality, but I
> doubt it is technically feasible yet.

Well, humans are more complex.  There are no sure-fire recipes even for
working with horses: some of them here have their separate paddocks
because things would not settle down, some of them have standard
conflicts, there are occasional injuries.  The most important "standard
recipe" is to make sure that the areas accessible to multiple horses do
not have dead ends small enough for one horse to be able to corner
another.  That's not really fabulous but still pretty essential.  Also
enough room all around, obviously.

Now humans are often held in conditions that are not species-appropriate
and lead to a buildup of tension.  Try finding an undisturbed spot in a
typical city suitable for devouring a bread roll you hunted down without
getting other predators eyeing your prey.  Almost impossible.

It may be that distributed version control systems offer more
possibilities for organizing cooperation in a manner leaving graceful
escape paths when things don't work out.  It's not what one want to have
to rely on permanently but it may be worth thinking about ways to make
consequences from difficulties less "inevitable" and/or grave.

-- 
David Kastrup
