From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 11:07:28 +0200
Message-ID: <1312362448.3261.861.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
	 <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
	 <4E0A08AE.8090407@web.de> <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com>
	 <20110801221203.GA31614@book.hvoigt.net>
	 <1312289914.3261.836.camel@Naugrim.eriador.com>
	 <CAJsNXT=93FHjbi42JKA3Pg7PGXs0kEONJ5AC5SSPpa5RSVqB=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: PJ Weisberg <pjweisberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 11:04:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoXNM-0004W2-ID
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 11:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab1HCJEX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 05:04:23 -0400
Received: from mail12.surf-town.net ([212.97.132.52]:45591 "EHLO
	mailgw19.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752594Ab1HCJEW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 05:04:22 -0400
Received: by mailgw19.surf-town.net (Postfix, from userid 65534)
	id ED1FA11191B; Wed,  3 Aug 2011 11:04:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw19.surf-town.net (Postfix) with ESMTP id A769F11191B;
	Wed,  3 Aug 2011 11:04:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw19.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw19.surf-town.net ([127.0.0.1])
	by localhost (mailgw19.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FdMBF23+etRv; Wed,  3 Aug 2011 11:04:15 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw19.surf-town.net (Postfix) with ESMTPSA id CE45C111919;
	Wed,  3 Aug 2011 11:04:08 +0200 (CEST)
In-Reply-To: <CAJsNXT=93FHjbi42JKA3Pg7PGXs0kEONJ5AC5SSPpa5RSVqB=A@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178549>

Le mardi 02 ao=C3=BBt 2011 =C3=A0 12:19 -0700, PJ Weisberg a =C3=A9crit=
 :
> On Tuesday, August 2, 2011, henri GEIST
> <henri.geist@flying-robots.com> wrote:
> > Le mardi 02 ao=C3=BBt 2011 =C3=A0 00:12 +0200, Heiko Voigt a =C3=A9=
crit :
> >> Adding the ability to point to git repositories outside of the
> worktree
> >> does not solve anything but rather creates more problems. Resolvin=
g
> such
> >> dependencies can not be achieved if only A knows that it needs
> version X
> >> and only B knows that it needs version Y.
> >>
> >
> > Why not it work perfect for me and for debian as well.
>=20
> In the Debian analogy: A knows that it needs version X, B knows that
> it needs version Y, but A does not know that if it installs version X=
,
> B will break.  That's the job of the superproject (Aptitude).
>=20

Your right.
