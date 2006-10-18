From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 15:10:22 +0200
Message-ID: <200610181510.23095.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45360DAE.8000702@op5.se> <20061018124320.GT75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 15:10:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaBBW-0004Fp-Ot
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 15:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWJRNKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Oct 2006 09:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWJRNKK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 09:10:10 -0400
Received: from qb-out-0506.google.com ([72.14.204.230]:49858 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030272AbWJRNKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 09:10:08 -0400
Received: by qb-out-0506.google.com with SMTP id p36so702088qba
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 06:10:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nqC/yVBunwoMR+iAycsGiB/yM8Nz9kFv1YqRtaIsKFtEldj8YOgItuAWm2gbI3I37xTXgr/Ipq61EXPyj0tqCz/qpsHo6Hthb3XjOcb20OOcNqOwiifn8UYh1Mj9AAnHEDUxDAC8DK897qvtrjChJP/80KsTxv7MCF/medmd+6Y=
Received: by 10.66.249.11 with SMTP id w11mr11731552ugh;
        Wed, 18 Oct 2006 06:09:48 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id z40sm918599ugc.2006.10.18.06.09.46;
        Wed, 18 Oct 2006 06:09:47 -0700 (PDT)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061018124320.GT75501@over-yonder.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29230>

Dnia =B6roda 18. pa=BCdziernika 2006 14:43, Matthew D. Fuller napisa=B3=
:
> On Wed, Oct 18, 2006 at 01:19:10PM +0200 I heard the voice of
> Andreas Ericsson, and lo! it spake thus:
> >=20
> > It's just that we have this one place where gitweb is installed,
> > which management likes whereas devs don't have that on their laptop=
=2E
> > It's also convenient to have one place to find all changes rather
> > than pulling from 1-to-N different people just to have a look at
> > what they've done.
>=20
> I think this just by itself lends support to:
>=20
> > The point I'm trying to make here is that the star config might be
> > the most common case today because
>=20
> c) Stars work well as a mental model for humans.
>=20
> Heck, in large, Linux is star-ish.  There s "2.6.1", "2.6.2", etc;
> that's a trunk.  Any time you have releases, you're establishing a
> "master" branch.  For most people using Linux, there's a trunk,
> whether it's the kernel.org trunk, or the "What Redhat ships" trunk,
> etc.  The closer you drill to the day-to-day work on the kernel, the
> farther it gets from trunks, but if it were full-mesh at all levels I
> don't think it would be nearly as usable for regular computing tasks
> as it is.

No, it is not. If you consider only published Linus repository, and
private repositories of other people, it usually is star-ish (although
mentioned situaltion where somebody else repository took place of cente=
r
of star-ish configuration wouldn't be possible in tru star-ish model).
But please take note of stable repository, -mm repository; the changes
are exchanged there and back again. And "What Redhat ships" is AFAIK
mix of different repositories and own patches.=20
=20
--=20
Jakub Narebski
Poland
