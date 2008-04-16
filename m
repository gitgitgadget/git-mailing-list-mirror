From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 22:55:24 +0200
Organization: At home
Message-ID: <fu5p3i$96n$1@ger.gmane.org>
References: <48028830.6020703@earthlink.net> <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <4804765B.2070300@davidnewall.com> <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <20080416132634.GA545@cs181133002.pp.htv.fi> <20080416200408.GA7764@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 23:06:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEg0-0000Ac-8H
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYDPUzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2008 16:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbYDPUzd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:55:33 -0400
Received: from main.gmane.org ([80.91.229.2]:58148 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbYDPUzc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:55:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JmEf4-0004dN-3l
	for git@vger.kernel.org; Wed, 16 Apr 2008 20:55:22 +0000
Received: from abwk183.neoplus.adsl.tpnet.pl ([83.8.234.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 20:55:22 +0000
Received: from jnareb by abwk183.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 20:55:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwk183.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79750>

Willy Tarreau wrote:

> Note to contributors: it's very handy when patches comes with a prope=
rly
> formated subject. Try to put one of the following words between brack=
ets
> to indicate the importance of the patch followed by a short descripti=
on:
>=20
> [MINOR] =A0 =A0minor fix, very low risk of impact
> [MEDIUM] =A0 medium risk, may cause unexpected regressions of low imp=
ortance or
> =A0 =A0 =A0 =A0 =A0 =A0which may quickly be discovered

[...]

And git-am strips such prefixes because of [PATCH] and [PATCH n/m] whic=
h
should be stripped.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
