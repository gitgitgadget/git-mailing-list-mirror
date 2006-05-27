From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ~/.git/config ?
Date: Sat, 27 May 2006 05:40:48 +0200
Organization: At home
Message-ID: <e58hnm$fss$1@sea.gmane.org>
References: <20060526152837.GQ23852@progsoc.uts.edu.au> <20060526193325.d2a530a4.tihirvon@gmail.com> <20060526163829.GB10488@pasky.or.cz> <1148697382.5599.1.camel@dv> <20060527025750.GM11941@pasky.or.cz> <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat May 27 05:40:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjpfa-0003lP-8y
	for gcvg-git@gmane.org; Sat, 27 May 2006 05:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWE0Dkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 May 2006 23:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWE0Dkv
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 23:40:51 -0400
Received: from main.gmane.org ([80.91.229.2]:65160 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751771AbWE0Dkv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 23:40:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FjpfV-0003kl-EC
	for git@vger.kernel.org; Sat, 27 May 2006 05:40:49 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 May 2006 05:40:49 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 May 2006 05:40:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20834>

Linus Torvalds wrote:

> PS. I really like my [alias "cmd"] idea. _All_ my ideas are great, of=
=20
> course, but this one seems even better than some others. No?

So, would we use it also for default options of commands, like

=A0=A0=A0=A0=A0=A0=A0=A0[alias "log"]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cmd =3D log -p -M -C

(we could implement "git whatchanges" as an alias, keeping it's man pag=
e, or
sharing it with "git log").

--=20
Jakub Narebski
Warsaw, Poland
