From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Tue, 24 May 2016 13:57:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605241352361.4449@virtualbox>
References: <nhlqd4$ekr$1@ger.gmane.org> <c07df4ac-08c9-8eaa-0233-06616945c857@web.de> <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com> <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de> <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com> <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605231310190.4122@virtualbox> <xmqqeg8sa9oq.fsf@gitster.mtv.corp.google.com> <5743DE28.5070000@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2121850293-1464091053=:4449"
Cc: Junio C Hamano <gitster@pobox.com>, Jon Forrest <nobozo@gmail.com>,
	git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 24 14:06:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5B6U-0000jh-6q
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 14:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbcEXMGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 08:06:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:62922 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbcEXMGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 08:06:20 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LrqNe-1bXL7J2uTO-013fyr; Tue, 24 May 2016 14:06:07
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5743DE28.5070000@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:w4HJbU5ny+F3SKpYryLRcLmV9uQedEMi1a20EITYjfyfILwwOE4
 9sr3rJvKNFGTp+sgbatxakRl4rLY+6wSM2PdpWh4xOi1xTlUpSUqeSf2AGehQKzCiCb2d16
 N2yR5BMl9EdkADq0epnxNBK4iBcUA38YzBuKcnFMmTMxFCoHqG44JjIne25Qul/fUPVCyLK
 G5xsS4LMHyYsut09maKWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XFn+wOOo5kc=:XEO185feyg90bGJScVDKBP
 gEhlDwV+/gM8eSD7Lflvz+VghUTZAKKdw1eLq0G91dAlShUnFHLwsUgQJ+xwXAFBFqEmlEaxf
 EcAVbqoQks0SuQBY6bmxpxdw6GXVS1lox6QaMYTl3mNYsG4nknaIPzTJUHeoB0Psb+kA1wnIX
 BDcujYefqbTy1C/iZk/9dVpj5OVxBjonlwwYLF40NnmuxGa+qxMm37xKLca0x44GgpU4UmU74
 QevGvdxFUPhPPRF04nHX4Ssw2RCqtfCO+wbTbSqYKYzNQ/V2QKxDUAebaB9SLfoiXy9q0kwG4
 yZ3dqilBhBbA3iJzdNBR/kfpq0UOj94hFKF2l+n9TbOFXsfgRH1abheUtCvIrauESAoJhsWEI
 cx/y4tZTfOsQ3L/LIvjMj0ha3TTnwvKzhCWlKGCkjAAUPbxBcTDkGROHPGqabu8jzpbrxex4e
 pTL1NcHY8VwRVYZca3jlJlXpa4xrP61ZkEha4N33wZcfLIo8qsBSyP415+3Vnx40XGTlnIJPi
 To/z4c+wY3D03htRq0Oz/mW4UQm4sDYB9gLu2eDAvBt5/Y5nb/07nPMD8FOZtKGKqfE5cl/CY
 VTnaIZVFwEM3ZG4qSwm5PN4bYYC+7OOcFkV0KgPF8+lgsh48kMkk67f/FwvPTIfGN3tla7ISD
 Kx/XGSVBkiuxgO/LpkwFCBSZQiPNlP1qipJv86Pkjx+QXJLKqHSvQNInj1GssyZ6qDYXs7kHt
 kw5TTjeaccCoKYrIgEOBVKgQpN7Y8WbCNb5fzdepIA5mevb/9A4XVzSSbb0ovDWQNytE9kug 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295490>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2121850293-1464091053=:4449
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 24 May 2016, Torsten B=C3=B6gershausen wrote:

> On 05/23/2016 08:52 PM, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > > Of course, if you are doing network mount between systems with and
> > > > without filemode support, the result would depend on where you did
> > > > the "git init", so that would not help.
> > > >
> > > > Which means that other probed things like symlink support and case
> > > > sensitivity are likely to be wrong in the .git/config that the
> > > > user may want to fix.
> > >
> > > What we could do is to make the default config setting
> > > platform-dependent, a la CRLF_NATIVE.
> > >
> > > I imagine that we would want this for core.filemode, core.ignorecase =
and
> > > core.symlinks.
> > >
> > > What do you think?
> >
> > The reason why we probe for filemode, icase, etc. at repository
> > creation time and record the result in the configuration is because we
> > do not to want to do the auto-probing at runtime, every time we run
> > any Git command.

Right, I missed this of course. My idea was to have saner defaults *iff
the config variables are not set explicitly*. But they *are* set, of
course. Just not in a way that makes sense when the very same working
directory is accessed from different Operating Systems.

> if core.filemode is true, Git for Windows could:
> a) Behave as today, report changed files (filemode)
> b) Give warning to the user (and report changed filemode)
> c) Error out, saying misconfigured worktree
> d) use core.filemode =3D false anyway.
> e) Give a warning and use core.filemode =3D false anyway.
>=20
> At the moment I tend for c), as it makes it clear what is going wrong,
> what do you think ?

The problem with that is that we would need to probe again. Or dictate for
all eternity that Git for Windows cannot determine the executable bit (but
who knows for certain?)

I am pretty convinced that we should go with a)

Ciao,
Dscho
--8323329-2121850293-1464091053=:4449--
