From: Francis Galiegue <fg@one2team.net>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 21:30:02 +0100
Organization: One2team
Message-ID: <200810312130.03037.fg@one2team.net>
References: <200810312050.31167.fg@one2team.net> <20081031201127.GA21345@maintenance05.msc.mcgregor-surmount.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:31:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0et-0001B3-5G
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYJaUai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 16:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbYJaUai
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:30:38 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:45672 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYJaUah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Oct 2008 16:30:37 -0400
Received: from erwin.kitchen.eel (AOrleans-157-1-104-197.w90-20.abo.wanadoo.fr [90.20.179.197])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 93D7492C011
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 21:30:25 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081031201127.GA21345@maintenance05.msc.mcgregor-surmount.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99639>

Le Friday 31 October 2008 21:11:27 Ian Hilt, vous avez =E9crit=A0:
[...]
> >
> > Unless I'm mistaken (and I probably am), the $(...) construct is
> > bash-specific, isn't it?
>
> Nope.  Read section 2.6.3 Command Substitution here,
>
> <http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.h=
tml>

My bad, then. I'm too "old-school", I guess ;)

--=20
fge
