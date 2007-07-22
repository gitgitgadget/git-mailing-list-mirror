From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Documentation/gitignore.txt: Fix the seriously misleading priority explanation
Date: Sun, 22 Jul 2007 11:12:03 +0200
Organization: Organization?!?
Message-ID: <85wswsol98.fsf@lola.goethe.zz>
References: <85wswtp8va.fsf@lola.goethe.zz> <7v4pjxt1nk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 11:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICXUP-0003qI-Iz
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 11:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759366AbXGVJMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 05:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760179AbXGVJMa
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 05:12:30 -0400
Received: from main.gmane.org ([80.91.229.2]:60830 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759124AbXGVJM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 05:12:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICXUG-000766-2H
	for git@vger.kernel.org; Sun, 22 Jul 2007 11:12:24 +0200
Received: from dslb-084-061-022-107.pools.arcor-ip.net ([84.61.22.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 11:12:24 +0200
Received: from dak by dslb-084-061-022-107.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 11:12:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-022-107.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:mR+oj5F9YDoBblliFx08OG0nvnw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53241>

Junio C Hamano <gitster@pobox.com> writes:

> Your rewrite makes "patterns found in deeper file overrides the
> ones in shallower ones" rule much much easier to read.  Thanks.

Well, it is nice for a change to be able to explain something in a way
that people understand.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
