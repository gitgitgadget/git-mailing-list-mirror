From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 11:07:29 +0200
Organization: At home
Message-ID: <gcseoi$790$1@ger.gmane.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net> <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 11:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kowx8-0008D1-2a
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 11:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbYJLJHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 05:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYJLJHn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 05:07:43 -0400
Received: from main.gmane.org ([80.91.229.2]:43926 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbYJLJHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 05:07:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KowvL-00052F-4m
	for git@vger.kernel.org; Sun, 12 Oct 2008 09:07:39 +0000
Received: from abxa211.neoplus.adsl.tpnet.pl ([83.8.250.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 09:07:39 +0000
Received: from jnareb by abxa211.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 09:07:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxa211.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98008>

Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
>> So I think it is probably reasonable to think about a new command (w=
hich
>> would not be called status) that shows this information.
>=20
> I was going to suggest the same. =A0"git st" for people who come from=
 "svn st"
> so that "git status" can be kept as traditional "preview of 'git comm=
it'".

Or "git inspect". Or "git info".

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
