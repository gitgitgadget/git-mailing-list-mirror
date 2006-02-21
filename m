From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-mktree: reverse of git-ls-tree.
Date: Tue, 21 Feb 2006 09:46:22 +0100
Message-ID: <43FAD35E.5080401@op5.se>
References: <7vk6bp43qm.fsf@assigned-by-dhcp.cox.net> <1140504750.16926.111.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, Tommi Virtanen <tv@debian.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 09:46:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBTAH-0005Mm-Mv
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 09:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbWBUIqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Feb 2006 03:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161436AbWBUIqY
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 03:46:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53452 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161435AbWBUIqX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 03:46:23 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 7BC846BCFF; Tue, 21 Feb 2006 09:46:22 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1140504750.16926.111.camel@evo.keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16525>

Keith Packard wrote:
> <internationalization-pedant-mode>
> On Mon, 2006-02-20 at 22:37 -0800, Junio C Hamano wrote:
>=20
>=20
>>+ * Copyright (c) Junio C Hamano, 2006
>=20
>=20
> I've been told by at least two lawyers that the string '(c)' has no
> legal meaning in the US. If you want to indicate copyright, the only
> symbol which does carry legal weight is the c-in-a-circle mark '=C2=A9=
'.=20
>=20
> Of course, this does force the issue of what encoding to present sour=
ce
> files in. I suggest that sources should be UTF-8, which also provides
> opportunities to encode author names correctly, rather than
> transliterating them to Latin. X.org uses UTF-8 for source files now
> without difficulty across a wide range of compilers. Of course,
> non-ascii glyphs are present only in comments.
>=20
> </internationalization-pedant-mode>


In most countries the copyright is implied unless explicitly void by th=
e=20
author.

In other sane countries (I don't argue that USA is necessarily any such=
=20
country), the law is such that if the copier understands that there is =
a=20
copyright and violates it, he or she is in error and thus liable.

I'm not sure how mad such a law can be written, but what you describe g=
o=20
against both common sense and common practice since it puts the burden=20
of protection on the victim-to-be before the crime is even committed. I=
t=20
would be like a rapist being let off because his victims were where he=20
happened to be.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
