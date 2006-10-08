From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does GIT require property like Subversion?
Date: Sun, 08 Oct 2006 18:40:20 +0200
Organization: At home
Message-ID: <egb9js$1sk$1@sea.gmane.org>
References: <4528C09B.3030004@gmail.com> <20061008091900.GG30283@lug-owl.de> <egaj49$424$1@sea.gmane.org> <200610081752.10940.robin.rosenberg.lists@dewire.com> <20061008162410.GK20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 08 18:40:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWbgw-00010r-3a
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 18:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWJHQjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 12:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWJHQjo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 12:39:44 -0400
Received: from main.gmane.org ([80.91.229.2]:62599 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751267AbWJHQjn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 12:39:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWbgd-0000zB-QB
	for git@vger.kernel.org; Sun, 08 Oct 2006 18:39:36 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 18:39:35 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 18:39:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28542>

Petr Baudis wrote:
> Dear diary, on Sun, Oct 08, 2006 at 05:52:10PM CEST, I got a letter
> where Robin Rosenberg <robin.rosenberg.lists@dewire.com> said that...
>> s=F6ndag 08 oktober 2006 12:16 skrev Jakub Narebski:

>>> But in fact the philosophy of Git _prohibits_ I think property bits=
=2E

>> I don't think so, but they aren't needed for the original purpose. G=
it
>> already does manage file permissions.
>=20
> Incorrect, Git manages only the execute bit.

And symlinks.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
