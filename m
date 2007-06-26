From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Teach rebase -i about --preserve-merges
Date: Tue, 26 Jun 2007 02:15:48 +0200
Organization: At home
Message-ID: <f5plgb$uvl$1@sea.gmane.org>
References: <Pine.LNX.4.64.0706251859270.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 02:10:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ydI-0000Oz-Kh
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 02:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbXFZAKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Jun 2007 20:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbXFZAKJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 20:10:09 -0400
Received: from main.gmane.org ([80.91.229.2]:51477 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbXFZAKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 20:10:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I2yd1-0000Zm-Eg
	for git@vger.kernel.org; Tue, 26 Jun 2007 02:09:55 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 02:09:55 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 02:09:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50939>

Johannes Schindelin wrote:

> *2*: git-rebase without --interactive is inherently patch based (at
> =A0 =A0 =A0least at the moment), and therefore merges cannot be prese=
rved.

What about "git rebase --merge"?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
