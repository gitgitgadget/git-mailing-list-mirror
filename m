From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: SVN -> Git *but* with special changes
Date: Sun, 08 Jan 2012 11:47:52 +0100
Message-ID: <m2hb06mpwn.fsf@linux-m68k.org>
References: <1317227849979-6840904.post@n2.nabble.com>
	<20110928190445.GC1482@sigill.intra.peff.net>
	<1325999031923-7163706.post@n2.nabble.com>
	<20120108051051.GA10129@sigill.intra.peff.net>
	<1325999865995-7163737.post@n2.nabble.com>
	<1326000327637-7163752.post@n2.nabble.com>
	<20120108103303.GC2714@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Jan 08 11:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjqIB-0003VN-S1
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 11:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab2AHKrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 05:47:55 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:36682 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab2AHKry (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 05:47:54 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 45C0F1C0C156;
	Sun,  8 Jan 2012 11:47:50 +0100 (CET)
X-Auth-Info: 0x2tPPo7MFqlD7VdWdLf2r04cxh7iOihnrI0FNfeJso=
Received: from linux.local (ppp-88-217-114-77.dynamic.mnet-online.de [88.217.114.77])
	by mail.mnet-online.de (Postfix) with ESMTPA id 1E38D1C00153;
	Sun,  8 Jan 2012 11:47:50 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id AFD711E52FA; Sun,  8 Jan 2012 11:47:54 +0100 (CET)
X-Yow: I'm EXCITED!!  I want a FLANK STEAK WEEK-END!!  I think I'm JULIA
 CHILD!!
In-Reply-To: <20120108103303.GC2714@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Sun, 8 Jan 2012 11:33:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188098>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Sat, Jan 07, 2012 at 09:25:27PM -0800, Abscissa wrote:
>> Well that's strange, it finished "upgrading", but now git is still j=
ust
>> reporting 1.7.0.4, which is *exactly* the same version it said befor=
e. The
>> git-svn package should already be up-to-date because I just installe=
d it=20
>> today. So I don't know what's up with that.
>
> Nothing odd about that. apt-get upgrade means "upgrade my system". If
> you want to get a newer version of package X, you do apt-get install =
X
> and it will install the latest version of that package.

If apt-get upgrade doesn't get you a newer version then apt-get install
won't help you either.  Both use the same installation source.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
