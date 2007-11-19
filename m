From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: fix git-clone manpage not to refer to itself
Date: Mon, 19 Nov 2007 15:03:00 +0100
Organization: At home
Message-ID: <fhs52j$npp$1@ger.gmane.org>
References: <87ejeq1131.fsf@osv.gnss.ru> <Pine.LNX.4.64.0711191430460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 15:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu7E6-0006p0-Ro
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 15:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbXKSODc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2007 09:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbXKSODc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 09:03:32 -0500
Received: from main.gmane.org ([80.91.229.2]:55709 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbXKSODb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 09:03:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iu7DZ-0002a8-33
	for git@vger.kernel.org; Mon, 19 Nov 2007 14:03:17 +0000
Received: from abwr246.neoplus.adsl.tpnet.pl ([83.8.241.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:03:17 +0000
Received: from jnareb by abwr246.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:03:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwr246.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65446>

Johannes Schindelin wrote:

> On Fri, 16 Nov 2007, Sergei Organov wrote:
>=20
>> +ifndef::git-clone[]
>=20
> It is laudable that you want to fix the _generated_ documentation, bu=
t=20
> there are two things to keep in mind:
>=20
> - it does _nothing_ to help readers of the sources, and asciidoc was=20
> =A0 chosen purposely because the source is human-readable, and

IMHO it doesn't make source of documentation less readable.

It has the advantage of not duplicating contents, and being a bit mre
readable than writing "for <cmd>" in documentation contents.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
