From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Fixed two bugs in git-cvsimport-script.
Date: Wed, 17 Aug 2005 13:22:03 +0200
Message-ID: <u5t1x4s24h0.fsf@lysator.liu.se>
References: <u5tacjjdpxq.fsf@lysator.liu.se> <u5tiry50ywy.fsf@lysator.liu.se>
	<7v3bp829zj.fsf@assigned-by-dhcp.cox.net>
	<7vacjgyj94.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Aug 17 13:25:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5M1g-0003N8-AD
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 13:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVHQLYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Aug 2005 07:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVHQLYA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 07:24:00 -0400
Received: from main.gmane.org ([80.91.229.2]:62355 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751071AbVHQLX7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 07:23:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5M0U-00030L-Hb
	for git@vger.kernel.org; Wed, 17 Aug 2005 13:22:54 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 13:22:54 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 13:22:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:9rsJV2HRBT1vPWJWob2Nx2jIRqQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Yes, the patch had some context conflicts with some other patch
>> so the patch application was done by hand, and I did a quick and
>> dirty cut & paste of the commit message from "cat mbox" output.
>>
>> I will probably drop future patches encoded in QP.
>
> This was totally inappropriate; sorry, but I was in a bad mood.
>
> A more serious response.
>
>  - I personally consider commit message encoding a per project
>    issue (so is blob contents encoding).

Agreed.  And your response is probably good enough for now.  I also
think that having UTF-8 as the standard convention is the way to go.

--=20
David K=E5gedal
