From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 21:04:09 +0100
Organization: At home
Message-ID: <emhdir$he9$1@sea.gmane.org>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net> <86k60jsvh8.fsf@blue.stonehenge.com> <86fyb7sv9f.fsf@blue.stonehenge.com> <7vwt4jzrjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Dec 22 21:02:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxqaj-0007ES-25
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbWLVUCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbWLVUCA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:02:00 -0500
Received: from main.gmane.org ([80.91.229.2]:33669 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbWLVUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:01:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxqaS-0008Oe-2B
	for git@vger.kernel.org; Fri, 22 Dec 2006 21:01:48 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 21:01:48 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 21:01:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35204>

<opublikowany i wys=B3any>

Junio C Hamano wrote:

> Possibilities:
>=20
> =A0(1) Forget about that "protection" business. =A0If you do not
> =A0 =A0 =A0want mistakes, use 'branch.*.merge' but otherwise we will
> =A0 =A0 =A0continue to follow the good old "first set of branches"
> =A0 =A0 =A0rule.

What about marking default branch to merge explicitely using
"Merge:" in remotes/<repo>, or remote.<name>.merge?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
