From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Fri, 31 Oct 2008 00:55:17 +0100
Organization: At home
Message-ID: <gedhh6$urq$1@ger.gmane.org>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <alpine.LFD.2.00.0810301024300.13034@xanadu.home> <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org> <20081030150135.GG24098@artemis.corp> <alpine.LFD.2.00.0810301105350.13034@xanadu.home> <1225387882.19891.9.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 00:56:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvhNc-0005bG-1h
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 00:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbYJ3Xza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 19:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYJ3Xz3
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 19:55:29 -0400
Received: from main.gmane.org ([80.91.229.2]:58227 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbYJ3Xz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 19:55:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KvhML-0005Mf-9Q
	for git@vger.kernel.org; Thu, 30 Oct 2008 23:55:25 +0000
Received: from abvo7.neoplus.adsl.tpnet.pl ([83.8.212.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:55:25 +0000
Received: from jnareb by abvo7.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:55:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvo7.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99535>

Sam Vilain wrote:

> It's not about magic, it's about sensible defaults. =A0Currently this=
 use
> case is an error, and the resultant command is very long to type, and
> involves typing the branch name twice. =A0I end up writing things lik=
e:
>=20
> =A0 git checkout -b {,origin/}wr34251-do-something

Can't you use currently

    git checkout --track origin/wr34251-do-something


P.S. Somehow I don't see first message in this thread on GMane...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
