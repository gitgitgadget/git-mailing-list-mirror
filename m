From: Arne Babenhauserheide <arne_bab@web.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 08:16:02 +0100
Message-ID: <200810270816.06020.arne_bab@web.de>
References: <ge0rla$mce$1@ger.gmane.org> <200810270120.55276.arne_bab@web.de> <ee2a733e0810262115h705356dfmbc2237f8e88f3985@mail.gmail.com>
Reply-To: "Arne Babenhauserheide" <arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1534925.M6ENV1EyOh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, "Jakub Narebski" <jnareb@gmail.com>,
	git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 27 08:17:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuMLv-0005vW-7b
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 08:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYJ0HQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 03:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbYJ0HQL
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 03:16:11 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42987 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbYJ0HQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 03:16:10 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5CFADF30D375;
	Mon, 27 Oct 2008 08:16:09 +0100 (CET)
Received: from [217.227.70.45] (helo=fluss.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KuMKe-00050W-00; Mon, 27 Oct 2008 08:16:09 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.25-gentoo-r7; KDE/4.1.1; x86_64; ; )
In-Reply-To: <ee2a733e0810262115h705356dfmbc2237f8e88f3985@mail.gmail.com>
X-Sender: arne_bab@web.de
X-Provags-ID: V01U2FsdGVkX1+tEVA3dgWlyg7IljFPIxNcIpBFZ+kNiodgAmP9
	akiH0zOTB1HpS8wiZ2+D9uI6qR2wlg4DgBP46mYWIZzcPkWrSr
	t1Ad5eEJ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99211>

--nextPart1534925.M6ENV1EyOh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 27 Oktober 2008 05:15:11 schrieb Leo Razoumov:
> >  I created a head-to-head code_swarm of Mercurial and Git and it clearly
> > shows that Mercurial development didn't slow down.
>
> I am not familiar with code swarms, sorry. My impressions are
> subjective are thoroughly un-scientific:-)

That's always the case with code_swarms.=20

They only show the commit activity: How often how many files where changed.=
=20

They aren't a fair comparision but a damn unfair battle relying strongly on=
=20
development style, programming language (influences the style) and such.=20

What you can see very clearly in them is how activity patterns _change_.=20

And the Mercurial activity doesn't slow down.=20

Instead in the beginning you can see them pacing each other, git always the=
=20
bigger activity.=20
There was a moment in may this year when git activity had receded to the po=
int=20
where it was equal to Mercurials activity, but it recovered from that.=20

An artifact in Mercurial is that it took an almost two week break in July t=
his=20
year, but apart from that development always rolled on, and in august the=20
commits where coming fast again.=20

The smaller activity can for example be a result of a development style whe=
re=20
changes are thouroughly discussed before they get implemented.=20

> (1) Judging by the activity of mailing lists git community is several
> times larger and more active in terms of actual submitted patches.

This is something which didn't change. Git had higher activity from the sta=
rt,=20
yet Mercurials actual code paced it well and was faster at some things.=20

Git still has higher activity, but that can simply stem from Mercurial bein=
g=20
almost completely done in Python which need less code to do the same work.=
=20

> (2) Hg forest extension is still not in the tree with outdated and
> incorrect documentation in the wiki. For me it was biggest reason to
> migrate from Hg to git.

Why didn't you instead update the documentation in the wiki?=20

I don't use the forest extension, so I can't judge whether it is fit for=20
inclusion in the tree.=20

But I wrote the group extension and learned that way that writing Mercurial=
=20
extensions is far easier than I thought. And different from the shell, Pyth=
on=20
code is platform independent.=20

Best wishes,=20
Arne

=2D- My stuff: http://draketo.de - stories, songs, poems, programs and stuf=
f :)
=2D- Infinite Hands: http://infinite-hands.draketo.de - singing a part of t=
he=20
history of free software.
=2D- Ein W=FCrfel System: http://1w6.org - einfach saubere (Rollenspiel-) R=
egeln.

=2D- PGP/GnuPG: http://draketo.de/inhalt/ich/pubkey.txt

--nextPart1534925.M6ENV1EyOh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkFarUACgkQMwdGm/6WxARHhgCfVHz3clwzj4yYddfgf5H9qzot
BmMAmwTtojabHxwnjqh8dItikowTyEtA
=Ri0f
-----END PGP SIGNATURE-----

--nextPart1534925.M6ENV1EyOh--
