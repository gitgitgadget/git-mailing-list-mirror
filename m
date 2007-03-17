From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Libification project (SoC)
Date: Sat, 17 Mar 2007 03:24:09 +0100
Organization: At home
Message-ID: <etfjb1$uof$1@sea.gmane.org>
References: <20070316042406.7e750ed0@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 03:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSOYc-0005X1-CJ
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 03:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbXCQCVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Mar 2007 22:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbXCQCVw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 22:21:52 -0400
Received: from main.gmane.org ([80.91.229.2]:36467 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbXCQCVv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 22:21:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HSOY5-0007Nm-K1
	for git@vger.kernel.org; Sat, 17 Mar 2007 03:21:37 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 03:21:37 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 03:21:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42417>

[Cc: git@vger.kernel.org]

Luiz Fernando N. Capitulino wrote:

> =A0 =A0 o Documentation (eg, doxygen)

I wonder if documenting and finishing documentation of git storage stru=
cture
(format description of: loose objects, packs, pack indices, index, refs=
 and
symbolic refs, packed refs) and git protocols (git protocol description=
,
local/ssh fetch/push pipeline description), perhaps using RFC or RFC-li=
ke
notation could (and should) be made part of libification effort...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
