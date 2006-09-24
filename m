From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [CFH] Remotes conversion script
Date: Sun, 24 Sep 2006 23:39:01 +0200
Organization: At home
Message-ID: <ef6tt8$2un$1@sea.gmane.org>
References: <20060924212142.GB20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 24 23:39:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRbgt-0007E6-FH
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 23:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWIXVjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 17:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIXVjI
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 17:39:08 -0400
Received: from main.gmane.org ([80.91.229.2]:15587 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932125AbWIXVjD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 17:39:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRbgc-0007AP-TL
	for git@vger.kernel.org; Sun, 24 Sep 2006 23:38:54 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 23:38:54 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 23:38:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27698>

Petr Baudis wrote:

> =A0 if someone is currently bored, it would be very nice to have a
> conversion script for converting remotes/ to [remote] .config section=
s
> (unless I missed it and someone already did such a great thing).
>=20
> =A0 I think about supporting just the [remote] sections in Cogito sin=
ce
> they are much easier to handle than the remotes/ file format, but in
> order to maintain reasonable degree of compatibility with current
> repositories (even freshly cloned since git-clone still generates tho=
se
> horrible things ;-) ) such a script would be a must... and since this=
 is
> not interesting strictly for Cogito only, I hoped that perhaps some c=
ore
> Git people would be interested to help here.

If I remember correctly currently only some functionality provided by
remotes file can be provided by [remote] and [branch] sections of git
config.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
