From: James Cloos <cloos+vger-git@jhcloos.com>
Subject: Re: cg update failing
Date: Wed, 20 Jul 2005 00:34:43 -0400
Message-ID: <m3oe8yw0ws.fsf@lugabout.cloos.reno.nv.us>
References: <m3oe95qn64.fsf@lugabout.cloos.reno.nv.us>
	<1121365461.4729.0.camel@localhost.localdomain>
	<m3k6jtnod8.fsf@lugabout.cloos.reno.nv.us>
	<1121376069.4729.2.camel@localhost.localdomain>
	<m3d5plm50o.fsf@lugabout.cloos.reno.nv.us>
	<m3eka04shr.fsf@lugabout.cloos.reno.nv.us>
	<20050720010712.GB2255@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Darrin Thompson <darrint@progeny.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 06:35:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv6IX-0001pS-Ul
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 06:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVGTEe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Jul 2005 00:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGTEe7
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 00:34:59 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:54031 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261626AbVGTEe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2005 00:34:58 -0400
Received: from lugabout.jhcloos.org (host-69-48-12-36.roc.choiceone.net [69.48.12.36])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP
	id DD99B1C5ED; Tue, 19 Jul 2005 23:34:50 -0500 (CDT)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 56E281AB2BF; Wed, 20 Jul 2005 04:34:43 +0000 (GMT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050720010712.GB2255@pasky.ji.cz> (Petr Baudis's message of "Wed, 20 Jul 2005 03:07:12 +0200")
X-Hashcash: 1:21:050720:pasky@suse.cz::+YC0Q4X67Xgxrwj9:0000M+Ra
X-Hashcash: 1:21:050720:git@vger.kernel.org::bVUKKXxGXNbgrwij:00000000000000000000000000000000000000000071Lq
X-Hashcash: 1:21:050720:darrint@progeny.com::+QnX9nxwz+8L/5Xh:000000000000000000000000000000000000000000B9cY
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "Petr" =3D=3D Petr Baudis <pasky@suse.cz> writes:

Petr> Huh. Well, you had to do uberweird things with your repository -
Petr> why did you cg-seek at all? What Cogito version is it?

All I ever did was track and compile linus=E2=80=99 tree.  IIRC, when t=
he
first new tag was added after I cloned the tree I had to seek to
that tag to see the new versions of the files.  But obviously
that was long enough before hg=E2=80=99s repo broke that I=E2=80=99d fo=
rgotten
how I=E2=80=99d done that....

I forget what version I started with.  I=E2=80=99ve been tracking gento=
o=E2=80=99s
ebuild since it entered portage.

-JimC
--=20
James H. Cloos, Jr. <cloos@jhcloos.com>
