From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: parsecvs repository moved...
Date: Mon, 16 Apr 2007 04:48:40 -0700
Message-ID: <20070416114840.GA1562@curie-int.orbis-terrarum.net>
References: <46a038f90704160032m9cfee8ai9830c81dd4a64cd6@mail.gmail.com> <20070416075829.GK2689@curie-int.orbis-terrarum.net> <46a038f90704160139o4a474876qfd5b3a6e21df279f@mail.gmail.com> <20070416084238.GL2689@curie-int.orbis-terrarum.net> <46a038f90704160151q2121086bx1b224804d93ba481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 13:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdPh6-0001hk-7V
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 13:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbXDPLsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 07:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbXDPLsX
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 07:48:23 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:33689 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030484AbXDPLsX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 07:48:23 -0400
Received: (qmail 22845 invoked from network); 16 Apr 2007 11:48:21 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Mon, 16 Apr 2007 11:48:21 +0000
Received: (qmail 5106 invoked by uid 10000); 16 Apr 2007 04:48:40 -0700
Content-Disposition: inline
In-Reply-To: <46a038f90704160151q2121086bx1b224804d93ba481@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44640>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The entirety of the subject is not worth further discussion. Beyond this
email, let's get back to the point of this list guys: Git development!
The keyword expansion flame-war is more on topic :-P

On Mon, Apr 16, 2007 at 08:51:13PM +1200, Martin Langhoff wrote:
>  On 4/16/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > No, it's correct in this case. I have it configured to collapse any
> > occurrence of my address into the list address, because I'm subscribed
> > to the list, and prefer to not receive duplicates.
>  OTOH you _are_ breaking the reply / reply-all convention that most
>  people use and (almost) all MUAs handle correctly.
I turned off Mutt's followup_to for this list now.

Simply put, MUAs have been getting it wrong for so long, that the entire
thing is a minefield. The Procmail-Tips documentation
(http://pm-doc.sourceforge.net/pm-tips-body.html#replyto_header)
has perhaps one of the best summaries of it:
] The way to solve most reply problems is to encourage the responder to
] actually think about where the message needs to go, and make it easy for
] him to get the behavior he wants.
It's the entirely of do what I mean, not what I say. Is my mail a reply
or a followup? Is it brash enough that I should make sure it goes only
to the right person?

>  If you'd rather not receive duplicates, you can probably filter out
>  for duplicates in by message-id at your MUA/procmail.
If it weren't for broken MUAs, then yes, this would solve it. The best
implementations of this so far have been for uniques on the tuple of
(From, Message-ID, Subject[prefixes removed], Fuzzy body).

> > Gentoo Linux Developer & Council Member
>  Oh, well. And I thought reply-to flamewars were exclusive to
>  debian-devel. They are silly enough there.
I'm not trying to start a flamewar, I get enough of those on gentoo-dev
already ;-).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGI2KYPpIsIjIzwiwRAgkWAJ4hXToH6o9pu7bQhtO+s7E+D7/+zQCfa0mF
hMWcIW9l25mEUOerr8I336E=
=38T3
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
