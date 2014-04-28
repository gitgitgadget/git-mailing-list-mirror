From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Mon, 28 Apr 2014 22:26:45 +0200
Message-ID: <87d2g142uy.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<1398470210-28746-2-git-send-email-dak@gnu.org>
	<7vmwf8huey.fsf@alter.siamese.dyndns.org>
	<87zjj86j4a.fsf@fencepost.gnu.org>
	<xmqqzjj5s8hs.fsf@gitster.dls.corp.google.com>
	<87y4yp4ame.fsf@fencepost.gnu.org>
	<xmqq38gxqmc9.fsf@gitster.dls.corp.google.com>
	<CAL=YDW=iTQz-S+ZByZnVhrpebPgZxq6p46MC2yqW-HF3eVw+2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:26:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wes8a-0006Ig-5P
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbaD1U0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 16:26:47 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:42778 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbaD1U0r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 16:26:47 -0400
Received: from localhost ([127.0.0.1]:41819 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wes8U-0005TY-74; Mon, 28 Apr 2014 16:26:46 -0400
Received: by lola (Postfix, from userid 1000)
	id CB8D4E05FE; Mon, 28 Apr 2014 22:26:45 +0200 (CEST)
In-Reply-To: <CAL=YDW=iTQz-S+ZByZnVhrpebPgZxq6p46MC2yqW-HF3eVw+2g@mail.gmail.com>
	(Ronnie Sahlberg's message of "Mon, 28 Apr 2014 13:05:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247439>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Some projects, for example samba, provide a dedicated page on the
> project web site
> where vendors, and I think individuals, that provide services can lis=
t
> their information :
>
> http://www.samba.org/samba/support/
>
> Would this perhaps be a better solution?

Actually, it does not work for my situation at all but then my situatio=
n
is likely not typical enough to be worth catering for specifically.

The salient point with me is that my productivity drops by more than a
factor of 100 (no, that's not an exaggeration) when having to do
something I'm not interested in.

Which is the reason my deal with GNU LilyPond where I'm (interrupted by
the git-blame episode) basically lead programmer is that LilyPond users
give me whatever money they consider my work to be worth to them, and i=
n
return I work on whatever I like on LilyPond.  Nobody gets to say _what=
_
I=A0do, and that's to the best of everyone's interest since only that w=
ay
a reasonable amount of work actually gets done.

So I cannot actually provide "services for hire" but it's more like a
"themed money sink" I=A0can offer.  And in the case of Git, since it do=
es
not even appear that there is a continuing base to make it work
reasonably in the context of other contributors and their interests,
it's more like "oops, I ended up wasting months on your project, but at
least there was something to show for it from my side, how about
yours?".  That's not something one can reasonably put on a "support"
themed page.  It's actually bloody ridiculous but then that's the sort
of handicap I=A0have to organize my life around.  Even while it's
unpredictable what I=A0end up doing, once I do get something done it te=
nds
to be pretty good (there are a few old performance patches of mine in
the Git code base where I did not start out from what happens to be
pretty awful code and still got considerable return).

--=20
David Kastrup
