From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push) to RPM spec.
Date: Mon, 14 Nov 2005 18:25:06 +0100
Message-ID: <u5tacg716rx.fsf@fidgit.hq.vtech>
References: <4376C797.3050600@matysik.co.nz>
	<Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
	<437788A0.6030103@op5.se>
	<Pine.LNX.4.64.0511131137470.3263@g5.osdl.org>
	<4377A3E1.7070003@op5.se>
	<Pine.LNX.4.64.0511131248190.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Nov 15 08:41:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbvR1-0004B0-GZ
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 08:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVKOHkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 02:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVKOHkT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 02:40:19 -0500
Received: from main.gmane.org ([80.91.229.2]:30927 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751321AbVKOHkR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 02:40:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EbvOu-00037r-Jp
	for git@vger.kernel.org; Tue, 15 Nov 2005 08:38:44 +0100
Received: from c-3b86e253.041-50-7570701.cust.bredbandsbolaget.se ([83.226.134.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 08:38:44 +0100
Received: from davidk by c-3b86e253.041-50-7570701.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 08:38:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-3b86e253.041-50-7570701.cust.bredbandsbolaget.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:W1BBN/Km9i87tmuD2+04/EXztWg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11881>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 13 Nov 2005, Andreas Ericsson wrote:
>>=20
>> I *think* the ssh transport should work nicely over rsh as well. I d=
on't have
>> the slightest idea of where to find an rsh installation to test it w=
ith
>> though.
>
> You're right, it should be possible to just do a
>
> 	export GIT_SSH=3Drsh
>
> and things should just work.
>
> But I don't have any machines that allow rsh either ;)

I do it all the time with a kerberos rsh.  It works fine.

--=20
David K=E5gedal
