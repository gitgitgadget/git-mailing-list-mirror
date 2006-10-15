From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 20:18:57 +0200
Organization: At home
Message-ID: <egtu1r$813$1@sea.gmane.org>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net> <7virim10rb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610151135110.17085@xanadu.home> <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 15 20:19:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZAZs-00051S-5k
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWJOSTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Oct 2006 14:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWJOSTI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:19:08 -0400
Received: from main.gmane.org ([80.91.229.2]:35022 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030200AbWJOSTF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 14:19:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZAZZ-0004yL-GZ
	for git@vger.kernel.org; Sun, 15 Oct 2006 20:18:53 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 20:18:53 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 20:18:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28923>

Junio C Hamano wrote:

> I think that is sensible. =A0I also was thinking that we should
> call the current one packv3 and the one with delta-base-offset
> packv4.

Just curious: what was the difference between packv1 and packv2,
and packv3 and packv4?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
