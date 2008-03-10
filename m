From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFE] git rebase doesn't say it failed
Date: Mon, 10 Mar 2008 12:53:58 +0100
Organization: At home
Message-ID: <fr37gm$9k4$2@ger.gmane.org>
References: <429AC7A2-511E-496F-9C1C-4627604EBBFB@gmail.com> <alpine.LSU.1.00.0803101207120.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 12:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYgbc-00082a-3X
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 12:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbYCJLzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 07:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbYCJLzJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 07:55:09 -0400
Received: from main.gmane.org ([80.91.229.2]:48062 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbYCJLzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 07:55:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JYgas-0006wF-U5
	for git@vger.kernel.org; Mon, 10 Mar 2008 11:55:02 +0000
Received: from abwl132.neoplus.adsl.tpnet.pl ([83.8.235.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 11:55:02 +0000
Received: from jnareb by abwl132.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 11:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwl132.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76722>

Johannes Schindelin wrote:

>> Git was unable to rebase due to the files above. =A0Please commit th=
em or move
>> them out of the way.
>> Hint: See "git reset --help" for a suggestion about saving work in p=
rogress.
>=20
> The same comment I gave last week applies here: people complained tha=
t Git=20
> was too chatty. =A0I tend to agree, since the important information w=
as lost=20
> in the huge amount of text. =A0Now you say we should make it chatty a=
gain?

--verbose option, anyone?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
