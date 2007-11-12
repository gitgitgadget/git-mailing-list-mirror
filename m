From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 16:37:09 +0100
Organization: At home
Message-ID: <fh9rv5$g06$1@ger.gmane.org>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 16:38:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbMd-0008De-AL
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXKLPiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 10:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXKLPiA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:38:00 -0500
Received: from main.gmane.org ([80.91.229.2]:46312 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbXKLPh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:37:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrbLx-0000UW-Dc
	for git@vger.kernel.org; Mon, 12 Nov 2007 15:37:33 +0000
Received: from abwz76.neoplus.adsl.tpnet.pl ([83.8.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 15:37:33 +0000
Received: from jnareb by abwz76.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 15:37:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz76.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64640>

Ping Yin wrote:

> ---
> =A0Documentation/git-commit.txt | =A0 10 +++++
> =A0Documentation/git-status.txt | =A0 =A03 +
> =A0git-commit.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 90 ++++++++++++=
++++++++++++++++++++++++++++--
> =A03 files changed, 99 insertions(+), 4 deletions(-)

Shouldn't you also modify Documentation/config.txt ?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
