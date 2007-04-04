From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] rename contrib/hooks/post-receieve-email to contrib/hooks/post-receive-email.
Date: Wed, 04 Apr 2007 15:25:48 +0200
Organization: At home
Message-ID: <ev08qg$fib$1@sea.gmane.org>
References: <20070404115212.17022.qmail@44e948019c99c4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 15:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ5Rs-00059I-75
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 15:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbXDDNWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 Apr 2007 09:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753793AbXDDNWs
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 09:22:48 -0400
Received: from main.gmane.org ([80.91.229.2]:35898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbXDDNWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 09:22:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HZ5Rc-0001K8-6W
	for git@vger.kernel.org; Wed, 04 Apr 2007 15:22:36 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 15:22:36 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 15:22:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43736>

Gerrit Pape wrote:

> ---
> =A0contrib/hooks/post-receieve-email | =A0588 -----------------------=
--------------
> =A0contrib/hooks/post-receive-email =A0| =A0588 +++++++++++++++++++++=
++++++++++++++++
> =A02 files changed, 588 insertions(+), 588 deletions(-)
> =A0delete mode 100644 contrib/hooks/post-receieve-email
> =A0create mode 100644 contrib/hooks/post-receive-email

Would it be better to use git-format-patch -M ?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
