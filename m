From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 11 Aug 2007 15:49:16 +0200
Organization: At home
Message-ID: <f9keos$ni7$1@sea.gmane.org>
References: <7vodhemmnp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 15:49:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJrLg-0002Tz-Ck
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 15:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbXHKNtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 11 Aug 2007 09:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbXHKNtq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 09:49:46 -0400
Received: from main.gmane.org ([80.91.229.2]:40322 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbXHKNto (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 09:49:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJrLF-0008Ot-UH
	for git@vger.kernel.org; Sat, 11 Aug 2007 15:49:21 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 15:49:21 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 15:49:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55612>

Junio C Hamano wrote:

> * jc/diff-files (Fri Aug 3 13:33:31 2007 -0700) 1 commit
> =A0- git-diff: squelch "empty" diffs
>=20
> It appears that people like the idea; I re-did the patch and
> removed the option like Steve did. =A0I'll look at it again and
> probably merge it to 'master' over the weekend.

What about using config variable for that instead?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
