From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add --dry-run option to git-send-email
Date: Tue, 10 Oct 2006 23:03:31 +0200
Organization: At home
Message-ID: <egh1ou$fqm$1@sea.gmane.org>
References: <20061010145823.GB8993@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 10 23:05:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOmG-0006Q2-8t
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 23:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWJJVD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 17:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWJJVD4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 17:03:56 -0400
Received: from main.gmane.org ([80.91.229.2]:160 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030381AbWJJVDz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 17:03:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXOkF-0005uJ-BI
	for git@vger.kernel.org; Tue, 10 Oct 2006 23:02:36 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 23:02:35 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 23:02:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28671>

Matthew Wilcox wrote:

> Add a --dry-run option to git-send-email due to having made too many
> mistakes with it in the past week. =A0I like having a safety catch on=
 my
> machine gun.

+1

I'd like also for git-send-email to check if there are any patches to s=
end,
as I oftend did forgot to provide patches.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
