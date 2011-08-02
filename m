From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Tue, 2 Aug 2011 15:37:51 +0200
Message-ID: <201108021537.51651.jnareb@gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <CAMP44s2CWvzKyBAskVRq6Vte-CyCKwxBCZbSw_mbp=4a6ngCOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 15:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoFAg-0004rQ-O9
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 15:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab1HBNiC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 09:38:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64536 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1HBNiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 09:38:01 -0400
Received: by fxh19 with SMTP id 19so5629645fxh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=o/o03ovr6PLpsrWYMzwHuEafV7QrC1SFlskVkqGWkxg=;
        b=LGipSLhgw6pFVPDR0Dd1FAgxcvBuSwFiv4eomY2qQ6HQr3n5QTJg97DbgXi5j+7bH9
         c7s4SJMrwW9EP58X88GR0PB2sXpvWXxCzoZGGQYXHSZakQfM3MGSvO651GJxA3HWx4XS
         QBaOV7CYdgCqXdtFfjjFYjI1eJvOf58y/pmvE=
Received: by 10.204.32.207 with SMTP id e15mr1697951bkd.60.1312292279058;
        Tue, 02 Aug 2011 06:37:59 -0700 (PDT)
Received: from [192.168.1.13] (abwn226.neoplus.adsl.tpnet.pl [83.8.237.226])
        by mx.google.com with ESMTPS id x1sm1932923fah.0.2011.08.02.06.37.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 06:37:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAMP44s2CWvzKyBAskVRq6Vte-CyCKwxBCZbSw_mbp=4a6ngCOw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178468>

On Sun, 31 Jul 2011, Felipe Contreras wrote:
> 2011/7/25 Jakub Narebski <jnareb@gmail.com>:
> > I am planning doing annual Git User's Survey, and I'd like to ask f=
or
> > feedback.
>=20
> > =3D=3D=3D 16. Which of the following Git features do you use? =3D=3D=
=3D
> > (multiple choice, with other)
[...]
> > =C2=A0+ interactive commit / per-hunk comitting / partial commit
[...]
> > =C2=A0+ Other, please specify
> >
> > NOTES:
> > ^^^^^^
> > The problem is come up not with exhaustive list of features: there =
are
> > too many of them to list. =C2=A0The problem is coming up with list =
of
> > important and used enough often features.
> >
> > So: what features should be included in this list? =C2=A0What featu=
res
> > should be removed from above list of answers?
>=20
> *staging*! I have suggested this multiple times, it should be here th=
is one!
>=20
> - stage add / partial commit / interactive commit / per-hunk comittin=
g
> (e.g. git add -u/-i/-p)
> + stage / partial or interactive commits (e.g. git add -u/-i/-p, git
> diff --cached)

Well, it is there... sort of.  I can certainly extend this answer.=20
=20
> > =3D=3D=3D 19. Overall, how happy are you with Git? =3D=3D=3D
> > (single choice)
> >
> > =C2=A0* unhappy
> > =C2=A0* not so happy
> > =C2=A0* happy
> > =C2=A0* very happy
> > =C2=A0* completely ecstatic
> >
> > NOTES:
> > ^^^^^^
> > I'm not sure if this question is at all useful.
> >
> > There is also problem, that the current wording is considered biase=
d
> > by some, but on the other hand changing wording of answers would ma=
ke
> > it impossible to compare it to answers from previous surveys...
>=20
> What wording would you use?

I think I'll keep what we used before.
=20
> > =3D=3D=3D 20. In your opinion, which areas in Git need improvement?=
 =3D=3D=3D
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Please state your preference.
> > (matrix)
> >
> > =C2=A0 Columns: don't need / a little / some / much
> > =C2=A0+ user-interface
> > =C2=A0+ documentation
> > =C2=A0+ performance
> > =C2=A0+ more features
> > =C2=A0+ tools (e.g. GUI)
> > =C2=A0+ localization (translation)
> >
> > NOTES:
> > ^^^^^^
> > Are there any general areas that are missing from this list?
> > What are they?
>=20
> IDE integration, portability?

Portability, certainly.

IDE integration is a bit out of scope, as it is not strictly about Git
itself, but about Git "ecosystem".

As I wrote in separate email, I am thinking about adding a new question=
:

  21. In your opinion, what Git tools are needed, and which need improv=
ements?
=20
> > =3D=3D About this survey. Open forum. =3D=3D
> >
> > =3D=3D=3D 26. How did you hear about this Git User's Survey? =3D=3D=
=3D
> > (single choice, with other)
> >
> > =C2=A0* git mailing list
> > =C2=A0* git-related mailing list (e.g. msysGit, Git for Human Being=
s)
> > =C2=A0* mailing list or forum of some project
> > =C2=A0* #git IRC channel topic
> > =C2=A0* announcement on IRC channel
> > =C2=A0* git homepage
> > =C2=A0* git wiki
> > =C2=A0* git hosting site (or blog related to such site)
> > =C2=A0* software-related web site
> > =C2=A0* news or social news site (e.g. Digg, Reddit)
> > =C2=A0* blog (or blog planet)
> > =C2=A0* other kind of web site
> > =C2=A0* Twitter or other microblogging platform
> >
> > =C2=A0* other - please specify
> >
> > NOTES:
> > ^^^^^^
> > This list would of course be updated to reflect the list of (planne=
d)
> > announcement channels.
> >
> > There of course will be announcement on Git Mailing List, and perha=
ps
> > also on msysGit list / Google Group, and on Git For Human Beings
> > Google Group (if it exists). =C2=A0I'll announce it on #git, and as=
k op to
> > put short announcement in channel description, and I can announce i=
t
> > on other IRC channels. =C2=A0I would add announcement to main page =
of Git
> > Wiki, and as Git Homepage administrator to put announcement about G=
it
> > User's Survey.
> >
> > I usually tried to contact administrators of git hosting sites,
> > including git.kernel.org, repo.or.cz, GitHub, Gitorious, Assembla,
> > Codebase and Unfuddle, asking them to put announcement about
> > Git User's Survey either somewhere on the site, or in their blog
> > (if there is any). =C2=A0What git hosting sites it is worth to ask?
>=20
> Google+ (maybe facebook).

They are not git hosting sites ;-)

Anyway, on Google+ there are 36 people who have me in their circles,
I have 28 followers on Twitter.  Identi.ca, Plurk, Facebook - here
I don't have or almost don't have "friends"/"subscribers"/"fans".

That's not much, so please: forward / share.
=20
> > I would like to have announcement of Git User's Survey 2010 at
> > LWN.net, but this would need to be send at least two weeks in advan=
ce,
> > if I remember correctly. =C2=A0Is it worth it? =C2=A0What other new=
s site should
> > I (or you) send announcement to?
> >
> > If you can Digg / Reddit announcment on some site, please do. =C2=A0=
I can
> > announce Git User's Survey 2-1- at Twitter, Identi.ca and Plurk, bu=
t I
> > don't have wide area of followers. =C2=A0So please RT.
>=20
> I can post it on reddit :)

Thanks in advance.
=20
> > Should we contact some bloggers (besides asking Junio to put
> > announcement on his blog) to post an anouncement? =C2=A0Which blogg=
ers
> > would respond positively (perhaps Linus...)?
>=20
> I can post it on gitlog. It looks like there are now many people chec=
king it.

Thanks in advance, again.

--=20
Jakub Narebski
Poland
