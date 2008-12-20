From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Sat, 20 Dec 2008 22:02:56 +0100
Message-ID: <200812202202.57159.markus.heidelberg@web.de>
References: <200812191314.19302.markus.heidelberg@web.de> <7v3agiy5gs.fsf@gitster.siamese.dyndns.org> <87tz8yponl.fsf@iki.fi>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Dec 20 22:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE8ze-000898-67
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 22:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbYLTVC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Dec 2008 16:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbYLTVC4
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 16:02:56 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:52553 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbYLTVCz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2008 16:02:55 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id A226FF5A5AA9;
	Sat, 20 Dec 2008 22:02:54 +0100 (CET)
Received: from [91.19.0.168] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LE8yM-0005I6-00; Sat, 20 Dec 2008 22:02:54 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <87tz8yponl.fsf@iki.fi>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18sGhtH3G/PQuRfkeHaAa62C27be1rLjH83cfad
	rpuTDaLXC1gmukjSNtU/Q9As1i+6zNqoMliRRLZ4pdzPSw+bL6
	P2XpyFXBtvzCJZZ6lBUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103666>

Teemu Likonen, 20.12.2008:
> Junio C Hamano (2008-12-20 12:08 -0800) wrote:
>=20
> > Markus Heidelberg <markus.heidelberg@web.de> writes:
> >
> >> Junio C Hamano, 20.12.2008:
> >>> Markus Heidelberg <markus.heidelberg@web.de> writes:
>=20
> >>> > -$ git show-branch --reflog=3D'10,1 hour ago' --list master
> >>> > +$ git show-branch --reflog=3D"10,1 hour ago" --list master
>=20
> >>> Is this just a personal taste, or a correction to typography?
> >>
> >> When using single quotes, the manpage displayed backticks.
> >
> > It does not seem to do that to me:
>=20
> The single quote (') in asciidoc turns into \' in the man page
> typesetting language and its meaning is acute accent (=B4, U+00B4).

Oh, right, it's not a backtick for me, but this acute accent. The other
direction downwards.
