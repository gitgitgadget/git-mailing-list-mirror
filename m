From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Mon, 5 Sep 2005 09:04:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509050902070.3568@evo.osdl.org>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org> <u5tvf1feedt.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 18:05:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECJSA-00034Z-6E
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 18:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVIEQEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Sep 2005 12:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVIEQEJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 12:04:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932304AbVIEQEI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 12:04:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j85G42Bo016985
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Sep 2005 09:04:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j85G3xxP016251;
	Mon, 5 Sep 2005 09:04:00 -0700
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <u5tvf1feedt.fsf@lysator.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8100>



On Mon, 5 Sep 2005, David K=E5gedal wrote:
>=20
> But to the users (like myself), there's no point in naming it by
> whether it's a script or a binary.=20

So? There's no downside.

To you, as a user, you never see the "-script" ending anyway. You'd nev=
er=20
type it out, or you're already doing something wrong.

So to users it doesn't matter, and to developers it _does_ matter (and=20
calling them ".pl" or ".sh" or something would be _bad_), why not pleas=
e=20
the developers?

> So your argument that it makes it easier for git developers to work
> with the source doesn't help the user.

It doesn't _help_ the user, but since it doesn't hurt him either, why t=
he=20
hell would we even _care_ about the user?

		Linus
