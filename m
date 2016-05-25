From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Wed, 25 May 2016 13:52:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605251349210.4449@virtualbox>
References: <nhlqd4$ekr$1@ger.gmane.org> <c07df4ac-08c9-8eaa-0233-06616945c857@web.de> <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com> <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de> <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com> <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605231310190.4122@virtualbox> <xmqqeg8sa9oq.fsf@gitster.mtv.corp.google.com> <5743DE28.5070000@web.de> <alpine.DEB.2.20.1605241352361.4449@virtualbox> <57452BB9.5090500@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1517380263-1464177160=:4449"
Cc: Junio C Hamano <gitster@pobox.com>, Jon Forrest <nobozo@gmail.com>,
	git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 25 13:52:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5XMk-0004Js-To
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 13:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbcEYLwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 07:52:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:54985 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbcEYLwm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 07:52:42 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MX1hk-1b080d3hae-00W1r3; Wed, 25 May 2016 13:52:36
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <57452BB9.5090500@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:8k5pzdexAkZlm7Wa1v3WNu0guJqIuX27nA0JGqJLedsq/D/+BFT
 NrcejOWxjHv3QF/sM9pSARRDJJklzF9MI+UVcF3+cZPnSS93wG47/KEfJ/T4aKxG4RfVtMH
 d57aBDQKYnpfO/FWn7Myh4Ky8/5gE6yFarp4rD4JpPxUcB6hFdYzdw5zwGcWxmyZF94H7sA
 B+AMAdfIM+HyKckPiXbIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gyzj5A9rhh4=:vYAQ/servL9CneMkiiZtxS
 J+PdoDhz1jBD0ZsUqD3hCot9c0rZBlvkezmSUcxdg7KCfriWYYoVitkHWWXWdfqo2sa1kkBQj
 KgHnRZa2fhnrFInPfdgG8rw5Mz7ykhJqtR+dCPMStZpp/CMvykPhPif2FDIeDqSqozT4RHoN8
 NP5zYEJ331f01XY3dTyqaGEiDQsWAPOjrorOA3zWhEWsZ+5Dni41nLVB87XqnnCh8aFgEYKdU
 1lbJjqX42p6DJnkxMwGaTh/lekq0DKhm5M8ZSw/3z5G4LK6/fbB6c1QO1WAHym7ldfQaaXfJq
 8DxMm7anxaBPFQQmrQDUKbSL+9ZGG3iMbysrna5jotPoJ5HvEfBc9IGTG/r6mE5mDz7SjaINq
 C9mEtRjxM2jIYymYqV2tgiSn+Kv8DiTRe2ma/cZUjCm9WCoNpFN4hQrtzc2yNz4pUL+HT8dNv
 IFXaV6cwzT9+9FO8NN3u0XZm5pmtdMzz8TQHg2qzlxNYVL7Az9BW9T7SdPpkHzaTq+lbu18AA
 Yl94U80UOEagVtoeRhSlI07ejH1i9v3UzPAY0usKzp3fLR4MRqUGFn3rtFHZOoOzQOyMq5+Dx
 VeGTqn7xj50t5heuKGVHv+c62fMl2baNqmIERc4TeHUzmrM2pUxQ1NVD/93NWY4tuphnGHKKN
 n/j769TqC5/z/pHNAihMZYMlCI9HsglD5vcVyfoE+BApetGGw1SrcrDIcMKEe0xs6vFRAW+kB
 Ocxzi0xSHyB7E3E0Pak80w/3TVUfJXJ/DRSylkVR95YyQQCb3NbxBINJSbaVZeUjBWNUNKCn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295571>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1517380263-1464177160=:4449
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Wed, 25 May 2016, Torsten B=C3=B6gershausen wrote:

> On 05/24/2016 01:57 PM, Johannes Schindelin wrote:
> >
> > On Tue, 24 May 2016, Torsten B=C3=B6gershausen wrote:
> >
> > > if core.filemode is true, Git for Windows could:
> > > a) Behave as today, report changed files (filemode)
> > > b) Give warning to the user (and report changed filemode)
> > > c) Error out, saying misconfigured worktree
> > > d) use core.filemode =3D false anyway.
> > > e) Give a warning and use core.filemode =3D false anyway.
> > >
> > > At the moment I tend for c), as it makes it clear what is going wrong=
,
> > > what do you think ?
> >
> > The problem with that is that we would need to probe again.
>
> The probing for the filemode:
> Wouldn't it be enough to run lstat() on .git/ ?

What about `git diff --no-index`? There is no `.git/` to probe there.

> If the user-execuatable bit is not set, but core.filemode is true, error
> out ?  That would not cost too much.

I think it would cost us a nice and clean logic ;-)

> > Or dictate for all eternity that Git for Windows cannot determine the
> > executable bit (but who knows for certain?)
>
> Can we can limit the eternity until the day when Windows can determine
> the executable bit ?

The point is: I will have forgotten by next week what we talked about
(there are way too many things going on in my life), and if and when
compat/mingw.c will be taught to infer the executable bit, I am prone to
forget that warning (if we introduce it).

Therefore, out of entirely practical considerations, I favor the status
quo.

Ciao,
Dscho
--8323329-1517380263-1464177160=:4449--
