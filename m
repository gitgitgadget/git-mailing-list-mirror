From: "R. Diez" <rdiezmail-temp2@yahoo.de>
Subject: Re: How to check out the repository at a particular point in time
Date: Mon, 22 Aug 2011 16:18:46 +0100 (BST)
Message-ID: <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
References: <201108221525.32982.trast@student.ethz.ch>
Reply-To: rdiezmail-temp2@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, in-git-vger@baka.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 22 17:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvWH8-0005zH-3r
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 17:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab1HVPSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 11:18:50 -0400
Received: from nm15-vm0.bullet.mail.ukl.yahoo.com ([217.146.183.252]:44909
	"HELO nm15-vm0.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752071Ab1HVPSs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 11:18:48 -0400
Received: from [217.146.183.181] by nm15.bullet.mail.ukl.yahoo.com with NNFMP; 22 Aug 2011 15:18:47 -0000
Received: from [217.146.183.33] by tm12.bullet.mail.ukl.yahoo.com with NNFMP; 22 Aug 2011 15:18:47 -0000
Received: from [127.0.0.1] by omp1022.mail.ukl.yahoo.com with NNFMP; 22 Aug 2011 15:18:47 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 103924.2152.bm@omp1022.mail.ukl.yahoo.com
Received: (qmail 51853 invoked by uid 60001); 22 Aug 2011 15:18:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1314026326; bh=jO4bUPSfhKOThd6mZgsBrfa2SvRZK9xYIPJrhjWtPmU=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=VKr9TBQFofUIdLwr04KuCbS2aGX0Yio44sRdJK6ZFNQrNW1dcszeqEgnutTFZH0kWG2sorgB8eSTZ+Gem1Sib5McYMAQ4u+jtbjaBgAzu6OTbTr9ZFM2TkhSb7IFp3Hez8A9c3Q6KiK1iDxhJg2dBxug6H/IeD2/++uUQ2Qggxk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HCUh9vKrNdtMIwWzTom9ZS+a/2lcfLEy3dwlCk8I9Cw4nKDNGRNjEfTtb1FrijZyYUVB9OXj+Xdu+WAFCNJ7J8uiS4Zkz7NF6BkFpNy/A4KSzABCsAkhhwks18ePCy95Q7K7iydxu7G0pD7hYZSZ0kaA8v+YzC9p4Of2H0INZLA=;
X-YMail-OSG: _IWYYvQVM1kS8RaQE5FkhnoacGWq8mTYQ2G1e1XFEFPh_MC
 sp9kPZ7kVuBn2rCyfuyxNH5a4_5J91AcTlNmwEVSKIuMbV905Kh6UpmrcXUd
 BDYAZ198pef3iT9YfflEOHxXBs3rSavuXt7tAp2UAZ56imZ.kogQOshztyWz
 BP4vTuW6WZo.JYW8OS7Cnc3su9.fARCHvoJnvynNFYPXxRUG4yWb.QJNtE_g
 CB6dgMuUh8CKAI4f2HCYYPKXgOjNfrowu6saReQG6mV5MHwVXrr5KVPQiHfK
 1aO_jPIqoLkq_mwxz41ambHyigDkN9ZCZXh7ZwTE7sRyfkqScz4SCU2oNcob
 saSztxvc5Ezr6vi4ENGLrdpOdD.ZtbrWciN4GzPsuHuRsvd23cNa_5YepgZP
 stBwEdos0vnbqLEN51w--
Received: from [188.72.244.60] by web25408.mail.ukl.yahoo.com via HTTP; Mon, 22 Aug 2011 16:18:46 BST
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.313619
In-Reply-To: <201108221525.32982.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179866>

Hallo Thomas Rast:

Thanks for your quick answer. Please see mine below.

> The @{date} and @{n} syntax refers to the reflog, which as
> the name
> tries to imply, is a log of where *your local ref* was at
> that
> time/step.=A0 Since the HEAD ref is by definition what
> you have checked
> out at the moment, HEAD@{1 hour ago} indeed refers to last
> year's version.

OK, thanks. That kind of example would be nice to have in the "git chec=
kout" documentation page. In the meantime, I've seen on the Internet th=
at other people also got caught by this... let's say... 'unintuitive' b=
ehaviour or documentation. 8-)


> It is a git-log option (or more precisely, revision walker
> option).

In the meantime, I've seen this done with "git rev-list" instead, like =
this:

  git rev-list -n 1 --before=3D"2010-11-01 11:45:16 +0000" master

Is that the same as with git-log ?


> The main problem is that your request is not very
> well-defined: in
> nonlinear history there will in general be more than one
> commit at the
> time requested.
>=20
> =A0 =A0 ---a----b----c----M----=A0=A0(M is a merge)
> =A0 =A0 =A0 =A0 \=A0 =A0 =A0 =A0 =A0 =A0 /
> =A0 =A0 =A0 =A0=A0=A0d-----e----f
>=20
> =A0 =A0 =A0 =A0 =A0 =A0=A0^----
> April 1st
>=20
> Suppose you ask git for "the newest commit as of April 1st"
> in this history.=A0 Is it supposed to give you b or d?

I still don't quite understand how git works, but let me risk a naive s=
tatement here. If "a-b-c-M" were 'master', and "d-e-f" were 'new-featur=
e', then on April 1st the current version on 'master' is 'b', because I=
 merged the 'new-feature' branch at a later point in time. Does that ma=
ke sense?


> Step back and consider the real problem here.=A0 In the

You're right in saying there is a race condition here between developer=
s, and the right solution would be of course to tag which versions work=
 well with each other.

But that problem the daily build is trying to solve is precisely that i=
t's too hard to keep track of all component versions in all repositorie=
s. Things just move too fast, and as far as I understand it, git submod=
ules require manual intervention. If I ever tag anything manually, it m=
ust have already passed the daily build!

The development model looks like this: the latest HEAD versions of all =
components should always work well with each other. If something breaks=
, the daily build will let the developer know by the next day. If two d=
evelopers make incompatible changes, they'll speak to each other and co=
mmit their changes within a few hours. During that time, they will be t=
rouble, but that's quite alright (at least for the moment).

I just didn't want the daily build to add to the uncertainty of what we=
nt wrong by introducing a few hours' worth of random time skew to the m=
ix.

The daily build server needs to check out from git the head status at s=
ay 02:00 am on all repositories, as if the server had so many CPUs that=
 it had ran a "git pull" for all of them simultaneously. That's close e=
nough for my purposes. Like stated above, if someone merges some old br=
anch at 02:01 am, a user that did a "git pull" on master at 02:00 am wo=
uld not have seen that merge, that's the effect I would like to achieve=
=2E

In the future there will probably be a stable HEAD branch and a develop=
ment branch with the same name across all git repositories, and the dai=
ly build can do both every day. Or maybe the stable versions will not c=
ome from git any more, but from .tar.gz files. Another solution to auto=
mate releases without so much human intervention would be as follows: i=
f the automated build and automated testing succeeded 3 hours ago, then=
 that timestamp can be entered in the database of "pretty sure it works=
" versions. The timestamp becomes effectively the version number. Manua=
lly coordinating all participants is hard if you don't have so many hum=
an resources.

Thanks again,
  R. Diez
