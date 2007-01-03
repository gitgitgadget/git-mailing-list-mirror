From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-remote
Date: Wed, 03 Jan 2007 23:05:24 +0100
Organization: At home
Message-ID: <enh953$7l0$1@sea.gmane.org>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 03 23:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ECX-0005XK-9l
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 23:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbXACWDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbXACWDJ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 17:03:09 -0500
Received: from main.gmane.org ([80.91.229.2]:55173 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbXACWDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 17:03:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H2EC5-0006Pr-IM
	for git@vger.kernel.org; Wed, 03 Jan 2007 23:02:45 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 23:02:45 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 23:02:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35894>

Junio C Hamano wrote:

> +elsif ($ARGV[0] eq 'add') {
> +=A0=A0=A0=A0=A0=A0=A0if (@ARGV !=3D 3) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print STDERR "Usage: gi=
t remote show <name> <url>\n";

I think you meant to write here "Usage: git remote add <name> <url>\n";
("add" instead of "show").
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
