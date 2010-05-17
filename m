From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Mon, 17 May 2010 17:04:56 +0200
Message-ID: <1274108567-sup-1380@nixos>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 17:05:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE1sk-0004Tt-Ov
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 17:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823Ab0EQPFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 11:05:04 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail.gmx.net ([213.165.64.20]:45073 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753494Ab0EQPFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 11:05:00 -0400
Received: (qmail invoked by alias); 17 May 2010 15:04:57 -0000
Received: from pD9E0AA3C.dip.t-dialin.net (EHLO mail.gmx.net) [217.224.170.60]
  by mail.gmx.net (mp061) with SMTP; 17 May 2010 17:04:57 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/E5rldjOzEkpPCxjowVJsVsX3Ehz76TKGEW9BEP5
	pXCh0S2Y+9Qbdh
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 17 May 2010 17:04:56 +0200
In-reply-to: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147243>

Excerpts from =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason's message of Sun M=
ay 16 00:10:09 +0200 2010:
> I couldn't find anything about this in the list archives. Have there
> been any discussions of adding internationalization support to Git
> itself? I.e. the interface messages that the core Git utilities emit.
>=20
> I tried to get started with integrating GNU Gettext, but gnuish
> assumptions it makes about building make it a bit hard.
>=20
> Is there perhaps another gettext implementation that would be more
> suitable for Git?
>=20
> I'd be interested in submitting patches to make the existing strings
> translatable if someone could get the tool + build skeleton going.

It may sound silly and stupid: My coworker has had much trouble because
he doesn't know English at all.
You could help those people very much by creating a git-translator.org
page where you can copy paste failures which are translated only.

In the end you must have seen any failure multiple times to cope with
it - no matter which language this message was written in. However
having an understandable text may help.

Marc Weber
