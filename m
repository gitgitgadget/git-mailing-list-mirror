From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Restore object-named links in item lists
Date: Thu, 12 Oct 2006 00:46:37 +0200
Organization: At home
Message-ID: <egjs8b$tmh$1@sea.gmane.org>
References: <20061011201812.26857.58295.stgit@rover> <20061011222101.36525.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Oct 12 00:48:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXmrE-0008B9-6j
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 00:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWJKWrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Oct 2006 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWJKWrU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 18:47:20 -0400
Received: from main.gmane.org ([80.91.229.2]:8138 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161255AbWJKWrS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 18:47:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXmqd-00081n-LX
	for git@vger.kernel.org; Thu, 12 Oct 2006 00:46:47 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 00:46:47 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 00:46:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28760>

Luben Tuikov wrote:

> But if this does go in, can you please remove the
> "hidden" links so that _less_ identical code is left
> to be maintained. =A0(I don't know anyone who's getting
> paid to maintain gitweb, do you?)

We could instead save common part of links in the temporary
variable. I quite like those "hidden links", they make area where
we can click larger.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
