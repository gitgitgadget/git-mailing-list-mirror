From: fork0@t-online.de (Alex Riesen)
Subject: Re: Git BOF notes
Date: Sun, 23 Jul 2006 09:38:18 +0200
Message-ID: <20060723073818.GA5822@steel.home>
References: <20060719230155.GJ13776@pasky.or.cz> <20060721132111.GD32585@fieldses.org> <20060721143115.GN13776@pasky.or.cz> <81b0412b0607210802q4d48b277yc4c45d4acbd890a6@mail.gmail.com> <fcaeb9bf0607221312k2088658bqa45e622b7fe244e4@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 23 09:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4YYK-0005ia-G9
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 09:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWGWHih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 23 Jul 2006 03:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWGWHih
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 03:38:37 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:52371 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750768AbWGWHih (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 03:38:37 -0400
Received: from fwd26.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1G4YXf-0006MK-07; Sun, 23 Jul 2006 09:38:23 +0200
Received: from tigra.home (SrQkT4ZAoe9Gyo4knpHNdy6i81GtxBiSRvTjNRlFPThl68kh-iBfc4@[84.160.104.23]) by fwd26.sul.t-online.de
	with esmtp id 1G4YXb-0t1QkC0; Sun, 23 Jul 2006 09:38:19 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CB7F4277AF;
	Sun, 23 Jul 2006 09:38:18 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G4YXa-0001X5-Nu; Sun, 23 Jul 2006 09:38:18 +0200
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0607221312k2088658bqa45e622b7fe244e4@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-ID: SrQkT4ZAoe9Gyo4knpHNdy6i81GtxBiSRvTjNRlFPThl68kh-iBfc4
X-TOI-MSGID: a3a932f9-32f1-4488-aa0b-701741edeb62
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24087>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Sat, Jul 22, 2006 22:12:07 +=
0200:
> >> I don't know if there's a point in being so paranoid - it already =
makes
> >> things more painful than necessary. In the tracking branch, you ju=
st
> >> want to have what the other side has anyway, and if the other side
> >> decided to jump around, why would you care otherwise?
> >
> >But for the ones who do care, it is much harder to notice. Even if i=
t is
> >a warning (it gets lost in crontab logs).
>
> Then create some lost+found branches for them?

if you copy files from ext3 to vfat, do you expect them to be found in
lost+found? Usually not, I believe. It should either fail or copy.
