From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/1] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 20:37:02 +0200
Organization: At home
Message-ID: <ehlmfg$bee$2@sea.gmane.org>
References: <200610230037.57183.jnareb@gmail.com> <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net> <200610240008.08325.jnareb@gmail.com> <20061024114923.GD20017@pasky.or.cz> <7vu01thbvb.fsf@assigned-by-dhcp.cox.net> <20061024172627.GU18879@pasky.or.cz> <7viri9h8m4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 24 20:38:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcR9R-0000YV-0d
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 20:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWJXShU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWJXShT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 14:37:19 -0400
Received: from main.gmane.org ([80.91.229.2]:38613 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161166AbWJXShR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 14:37:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcR92-0000Td-VG
	for git@vger.kernel.org; Tue, 24 Oct 2006 20:37:00 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 20:37:00 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 20:37:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29999>

Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:

>> Yes, I'm all for abbreviated names, but I'm against just writing
>> "parent" everywhere.
>=20
> Fully agreed. =A0Please make it so, if you so are inclined,
> perhaps between you and Jakub?

I'm all for abbreviated names (that was my first solution, wasn't it).
This patch was because of Junio mail:
> Would it even be necessary to use any SHA-1 name in these cases,
> I wonder.  Would it make the page less useful if we replace all
> of the above _commit_ with a fixed string, say, "parent"?

So please drop this patch.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
