From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 22:01:48 +0200
Organization: At home
Message-ID: <ees6n9$jdv$2@sea.gmane.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <7vhcz2jzfd.fsf@assigned-by-dhcp.cox.net> <20060920161825.GR8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 20 22:05:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ8Jq-0004ur-0j
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 22:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWITUFL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Sep 2006 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWITUFL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 16:05:11 -0400
Received: from main.gmane.org ([80.91.229.2]:44941 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750703AbWITUFJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 16:05:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GQ8Ja-0004qz-IW
	for git@vger.kernel.org; Wed, 20 Sep 2006 22:05:02 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 22:05:02 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 22:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27397>

Petr Baudis wrote:
=20
>> Seamless support is there and Linus described how without
>> breaking the usual "if not fast forward you may lose some
>> patches so be extra careful" safety valve.
>=20
> =A0 I argue that this safety valve is useless for most people (and
> actually I have hard time imagining a plausible scenario in which it
> actually _is_ useful). The support is not really seamless since you h=
ave
> to make manual changes to refspecs, while most people probably don't
> understand them (and shouldn't be required to if they are just tracki=
ng
> someone else anyway).

Or you can always pull with the --force option...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
