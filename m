From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 14:46:02 +0100
Organization: At home
Message-ID: <glhqdi$tec$1@ger.gmane.org>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <200901242347.23187.trast@student.ethz.ch> <alpine.DEB.1.00.0901250303150.14855@racer> <alpine.DEB.1.00.0901250324320.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 14:47:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR5KJ-0005c1-A0
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 14:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbZAYNph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2009 08:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755994AbZAYNpf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 08:45:35 -0500
Received: from main.gmane.org ([80.91.229.2]:56239 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755854AbZAYNpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 08:45:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LR5Ir-000123-CK
	for git@vger.kernel.org; Sun, 25 Jan 2009 13:45:33 +0000
Received: from abxc190.neoplus.adsl.tpnet.pl ([83.8.252.190])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 13:45:33 +0000
Received: from jnareb by abxc190.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 13:45:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxc190.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107058>

Johannes Schindelin wrote:

>> Hmm. =A0You're right, that is not really intuitive. =A0How about
>>=20
>> =A0=A0=A0=A0=A0=A0merge (B) A # Merge...
>>=20
>> instead?
>=20
> Or even better:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0merge B parent A' # Merge...

merge B with A' # Merge...=20

;-)

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
