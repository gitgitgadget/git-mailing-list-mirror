From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 20:58:54 +0200
Organization: Organization?!?
Message-ID: <85ir8ci7td.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707202135450.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org> <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org> <85tzrxslms.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org> <85644dqoig.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org> <85r6n1p7sb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org> <85fy3hp3f2.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org> <85abtpoydg.fsf@lola.goethe.zz> <alpine.L
 FD.0.999.0707221031050.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 20:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgeA-0006eo-QX
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762300AbXGVS7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762293AbXGVS7J
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:59:09 -0400
Received: from main.gmane.org ([80.91.229.2]:36431 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760888AbXGVS7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:59:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICgdz-0004pM-7z
	for git@vger.kernel.org; Sun, 22 Jul 2007 20:59:04 +0200
Received: from dslb-084-061-022-107.pools.arcor-ip.net ([84.61.22.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 20:59:03 +0200
Received: from dak by dslb-084-061-022-107.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 20:59:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-022-107.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:QbNdyE/gXM9ASdB4EWjVyB8K6rk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53293>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Jul 2007, David Kastrup wrote:
>>
>> So  when we are talking about a repository tree _becoming_ empty, we 
>> need the information whether or whether not we should remove it upon
>> becoming empty.
>
> You don't seem to realize - although I've told you now abotu a million 
> times - that what you are talking about is:
>
>  - technically exactly the same as ".gitignore", which for some 
>    unfathomable reason you cannot seem to accept.

Linus?  Do both of us a favor and forget about the "." proposal.
Since I already dropped it, we can save time if you rant about the
proposal I have replaced it with and call me an idiot for a different
reason.

> Quite frankly, Junio would be a total idiot to take any patches that do 
> what you want to do. Happily, he is anything but.

And he does not come across as one.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
