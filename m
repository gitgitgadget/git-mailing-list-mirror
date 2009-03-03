From: Jonas Smedegaard <dr@jones.dk>
Subject: Re: [TopGit] Multiple concurrent sets of patches
Date: Tue, 3 Mar 2009 23:07:09 +0100
Message-ID: <20090303220709.GY12820@jones.dk>
References: <20090303113741.GO12820@jones.dk> <20090303130316.GA17702@piper.oerlikon.madduck.net> <20090303192221.GV12820@jones.dk> <20090303194232.GB18423@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	x-action=pgp-signed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 23:09:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LecnO-00028P-AG
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 23:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758437AbZCCWH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 17:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759429AbZCCWHY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 17:07:24 -0500
Received: from 0x573b188a.cpe.ge-1-2-0-1101.hknqu1.customer.tele.dk ([87.59.24.138]:53676
	"EHLO xayide.jones.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759423AbZCCWHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 17:07:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by xayide.jones.dk (Postfix) with ESMTP id 0603011B961;
	Tue,  3 Mar 2009 23:07:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at jones.dk
Received: from xayide.jones.dk ([127.0.0.1])
	by localhost (xayide.jones.dk [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id JGefb9-8Ydpz; Tue,  3 Mar 2009 23:07:16 +0100 (CET)
Received: from auryn.jones.dk (auryn.jones.dk [192.168.222.52])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by xayide.jones.dk (Postfix) with ESMTPS id 6125911B7F9;
	Tue,  3 Mar 2009 23:07:16 +0100 (CET)
Received: by auryn.jones.dk (Postfix, from userid 1000)
	id 4B4391B977A; Tue,  3 Mar 2009 23:07:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090303194232.GB18423@pengutronix.de>
X-FOAF: http://dr.jones.dk/foaf.rdf
X-Face: "yShHCQ6@h{]=Se"1&kVc#Yd%l<B\s%RAjk)T'F6yYw3/unDabXtVB2LIg(-J0zo^aE2
	U[s (uhG@f$_ZpbxE53gCn:WZ_a.Gz8yI;ko-,iqW@*+8k<F$2G-nyl;^55>b=>9&
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEWbnI45Hxm/s6OD
	f2R0XU3Tzr2KjXXS5M59+7HJAAACY0lEQVQ4jW2TTW/jIBCGCa7ptdN4e0akbq9JTTmH
	MOu97nqLuLpxRK+rlSz//R3Ih9NqR4pI5uFlYDIv4yKKnuUQfWHYJQjESOuNdegOuL6A
	PSkiG4yFHFX7SRG1g1NU2zNJYDjur9JSzWWYOAGMab1IuFJFSiCulaR1OSvkTUobppSi
	b9DP5ADLxnDlfafsGZi0WDBNr2pPZAGwlwnQnXphq0iCBPxvgN0ZxLh5EDGdlCQElPIy
	ASbsnejpV5imsbOwSxuygr3T3emkicK/w4+0sqahIosMQkqMiysQD0dFIuPjBZhPIDzC
	xwk0GfBco4vlGzyfgYnDg0jvGwt0fGGVPwGSLC240nfacYn3nm7uM2hiRb1zbFfoQsnv
	VKpTRzAAWrS715Wof/rbSw2KylqEV/XEfTc9hyvw0DQHKP9I7qexvgbLoUEsp/z0epqB
	cY1G9z/Q0LC4eso9eb4GQ8+KljLppl8AX7W34zRO3l+DOBgu9VbNR42s0Rk4vsI1T13K
	ivHYEmq867UrymkMR3DpVXRGO8a9Cr4LtH8GtJ8mNFBKpoN8d76VRW2oH1Ot+JSGKHfX
	0UdXaDgPo5IflKchZk4jJgLYUg0vRZ32E8AURCxg+nfFS53zJ0AIoVqrWpo6p2eAzkKr
	6tXeqy+gJUkvtrWXOS8ZVIh0vmsGDbinEfq1zAKW3UpOq8jspfdTeCMbJIMkV2qSVW3Z
	1dSO8BfueDIO4FYDzU6FpVcsjGHc3GVDG7VCBLLk5mWU2xC831T90eVGY3b/1j+16dn2
	Prv2Se+UttbCElWxpaldwbdOrMU/uif692F3pH8AAAAASUVORK5CYII=
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112171>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, Mar 03, 2009 at 08:42:32PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>On Tue, Mar 03, 2009 at 08:22:21PM +0100, Jonas Smedegaard wrote:
>> On Tue, Mar 03, 2009 at 02:03:16PM +0100, martin f krafft wrote:
>> >also sprach Jonas Smedegaard <dr@jones.dk> [2009.03.03.1237 +0100]:
>> >> It seems to me that TopGit is incapable of handling this. That it=
=20
>> >> can only handle patchset against a single branch, and if the need=
=20
>> >> arise for restructuring an additional patchset for e.g. a stable=20
>> >> or oldstable branch, then quilt needs to be used manually anyway.
>> >
>> >Let me try to understand you: you want TopGit to maintain a single=20
>> >feature branch against two different source branches? How should=20
>> >that work? Could you elaborate a bit so that your needs become a bi=
t=20
>> >more obvious?
>>=20
>> Not quite. I want TopGit to maintain multiple feature branches,=20
>> preferrably related.
>>=20
>> With "related" I mean that I would like to be able to "fork" a chain=
=20
>> of interdependent feature branches.
>>=20
>> TopGit easily support one chain of branches:
>>=20
>> upstream + pristine-tar -> master -> build
>>=20
>> I want TopGit to additionally support the following:
>>=20
>> upstream + pristine-tar -> stable-master -> stable-build
>>=20
>> upstream + pristine-tar -> oldstable-master -> oldstable-build
>>=20
>>=20
>> E.g. in addition to TopGit branches t/fix_01 and t/feature_01 I woul=
d=20
>> want to fork those branches as t_stable/fix_01 and t_stable/feature_=
01.
>>=20
>>=20
>> I know that I can create all those TopGit branches one by one, but I=
=20
>> would then need to explicitly declare a list of TopGit branches to=20
>> apply each time I want to (re)generate a quilt patchlist.
>For my kernel development I use topgit topic branches that collect=20
>topgit patch branches.  Take this dependency graph:
>
>	linus/master <- t/armmisc/patch1 <- t/armmisc-master <- t/armmisc-pu
>	         ^ ^----t/armmisc/patch2 <--'                   |
>                 `------t/armmisc/patch3 <----------------------'
>
>So t/armmisc-master collects patches that are ready for upstream, -pu
>patches that need some more work.

My head is spinning - the dependency graph in my head was upside down=20
compared to your ascii art here.

I think I understand it . Thanks!

I will try it out - I converted ghostscript last week to using TopGit a=
s=20
an excercise: good challenge, a nice bunch of patches (but nothing near=
=20
as complex as kernel stuff, I know).


>	tg create t/fixes-squeeze/CVE-2009-abcd master-squeeze t/fixes-etch/C=
VE-2009-abcd
>	... no need to apply patch
>	... cherry-pick .topmsg from t/fixes-lenny/CVE-2009-abcd
>	git commit

Above puzzles me: Is cherry-picking .topmsg just a lazy way to write=20
same description for parallel topicbranch, or is it a trick to cheat=20
TopGit into believing that that branch never needs updating?


>But this doesn't help me for my kernel problem, because here I don't=20
>have that ordering on releases.  I want to manage patches on top of=20
>linux-tip and the ARM tree, but none of these contains the other :-/

I can only begin to imagine the complexities of dealing with parallel=20
tracks of kernel patching... Good luck with that!


Thanks a lot for your insight,

  - Jonas

- --=20
* Jonas Smedegaard - idealist og Internet-arkitekt
* Tlf.: +45 40843136  Website: http://dr.jones.dk/

  [x] quote me freely  [ ] ask before reusing  [ ] keep private
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmtqg0ACgkQn7DbMsAkQLhMFACgkW1FYlWnEP8unk+wVgAkd0i+
UMwAoKT1mkxIRP6XmNKt+Rj3iJn2yUpM
=3D7x2Z
-----END PGP SIGNATURE-----
