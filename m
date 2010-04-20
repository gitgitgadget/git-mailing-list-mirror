From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Tue, 20 Apr 2010 13:47:58 +0200
Message-ID: <20100420114758.GO10939@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004180246.18263.jnareb@gmail.com>
 <20100418005917.GO10939@machine.or.cz>
 <201004180324.54722.jnareb@gmail.com>
 <20100418021223.GP10939@machine.or.cz>
 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
 <20100418223120.GB3563@machine.or.cz>
 <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
 <20100419115727.GB10939@machine.or.cz>
 <o2le72faaa81004191110t1da6c2f9i3f5f8491df7a2681@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 13:48:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4BwG-0003F9-LS
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 13:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab0DTLsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 07:48:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51195 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab0DTLsF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 07:48:05 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id BDA0A125A15C; Tue, 20 Apr 2010 13:47:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <o2le72faaa81004191110t1da6c2f9i3f5f8491df7a2681@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145365>

On Mon, Apr 19, 2010 at 11:40:33PM +0530, Pavan Kumar Sunkara wrote:
> 2010/4/19 Petr Baudis <pasky@suse.cz>:
> >> >> b) Write modules of the client:
> >> >> =A015. Search for a part of code [git grep]
> >> >
> >> > This is already supported by gitweb. And it's not a "write" oper=
ation.
> >> > ;-)
> >>
> >> I wrote it here because I would like to integrate it with content
> >> history browser functionality later.
>=20
> If you remember, there is a gsoc idea named "Content History Browser"
> in ideas wiki page that is listed by you. It's about starting giddy
> from scratch to use pickaxe interface to see the history of a specifi=
c
> content. I would like to integrate this with that pickaxe interface.

Aha, I see. I will be curious what you come up with. :-)

> >> No, there will be a seperate page for it which executes git status=
 command.
> >
> > And just passes through its plaintext output? Well, I suppose that =
could
> > do for starters.
>=20
> No. It won't be just plain text. Every line will have links beside it
> to either stage or unstage or add or ignore or see diff for that file=
=2E

Ok!

> > Could you clarify your attitude to the support for mode without che=
cked
> > out working copy, using just the index, that we are discussing with
> > Jakub and I already mentioned to you in the past?
>=20
> Yes, I remember it. TO be frank, I don't know the git commands to
> implement this. So, If you can explain it to me more detailedly, Then
> I can implement it for sure.

See one of other Jakub's mails for examples of commands to be used.
If you have more specific questions, feel free to follow up.

--=20
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
