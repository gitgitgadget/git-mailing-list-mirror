From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 23:57:12 +0100
Organization: At home
Message-ID: <eoriau$n97$1@sea.gmane.org>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home> <7v1wlrle61.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701191437450.3011@xanadu.home> <7vbqkufyhy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701191729060.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 19 23:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H82fE-00062y-CT
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbXASW4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 17:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbXASW4t
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:56:49 -0500
Received: from main.gmane.org ([80.91.229.2]:48480 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbXASW4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:56:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H82f4-0003Ul-FJ
	for git@vger.kernel.org; Fri, 19 Jan 2007 23:56:42 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 23:56:42 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 23:56:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37217>

Nicolas Pitre wrote:

> Also, having:
>=20
> =A0 =A0git-am(1)
> =A0 =A0 =A0 =A0 =A0 Apply a series of patches from a mailbox.
>=20
> =A0 =A0git-applymbox(1)
> =A0 =A0 =A0 =A0 =A0 Apply a series of patches in a mailbox.
>=20
> looks a bit weird. =A0Why two commands with almost the same descripti=
on? =A0
> Maybe one of them could be relegated to ancillary? =A0Or even both of=
 them=20
> to foreignscminterface?

Because they are almost the same (same command, different interface).
git-applymbox is legacy for Linus.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
