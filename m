From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 02 Nov 2007 01:04:03 +0100
Organization: At home
Message-ID: <fgdphj$6ga$1@ger.gmane.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 01:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ink1V-00068N-13
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 01:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbXKBAEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2007 20:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755130AbXKBAEP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 20:04:15 -0400
Received: from main.gmane.org ([80.91.229.2]:60819 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687AbXKBAEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 20:04:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ink1B-0003Zt-3u
	for git@vger.kernel.org; Fri, 02 Nov 2007 00:04:09 +0000
Received: from abvq154.neoplus.adsl.tpnet.pl ([83.8.214.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 00:04:09 +0000
Received: from jnareb by abvq154.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 00:04:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq154.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63039>

Linus Torvalds wrote:

> On Wed, 31 Oct 2007, Junio C Hamano wrote:
>>=20
>> * ph/parseopt (Tue Oct 30 14:15:21 2007 -0500) 23 commits
>> =A0+ ...
>>=20
>> It appears 1.5.4 will be, to a certain extent, a "Let's clean up
>> the internal implementation" release. =A0This series should become
>> part of it. =A0Hopefully will merge to 'master' soon, but I
>> haven't looked this series very closely yet.
>=20
> I certainly think this should go in, but it does make one deficiency=20
> painfully clear: the remaining shell scripts end up having all the ol=
d=20
> flags behaviour.

Is 'getopts' bash-ism, or is it in POSIX?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
