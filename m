From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Worrisome bug trend
Date: Sat, 03 Mar 2007 03:28:27 +0100
Organization: At home
Message-ID: <esambr$a8f$1@sea.gmane.org>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net> <86odnfr625.fsf@blue.stonehenge.com> <7vzm6zcpv0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNK7B-0002FP-B0
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 03:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992867AbXCCCgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 21:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992904AbXCCCgj
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 21:36:39 -0500
Received: from main.gmane.org ([80.91.229.2]:56992 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992867AbXCCCgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 21:36:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HNK4l-0004Xd-NB
	for git@vger.kernel.org; Sat, 03 Mar 2007 03:34:23 +0100
Received: from host-81-190-30-210.torun.mm.pl ([81.190.30.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 03:34:23 +0100
Received: from jnareb by host-81-190-30-210.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 03:34:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-30-210.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41266>

Junio C Hamano wrote:

> 50892777 (diff --git a//etc/inittab)
> =A0=A0=A0=A0=A0=A0=A0=A065056021 Apr 28 2006 (first built-in diff)
>=20
> Me, while looking at recent "diff --no-index" series, by noticing
> breakage.=20

By the way, I'm not sure if it is _not_ an error, a way to distinguish
between in-tree path that begins from top of repository, and absolute
out of tree path which beings in root '/'. But perhaps
/etc/inittab instead of a//etc/inttab or a/etc/inittab would be better.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
