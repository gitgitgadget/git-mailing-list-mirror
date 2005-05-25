From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Wed, 25 May 2005 22:31:31 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.05.25.20.31.31.129474@smurf.noris.de>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> <7vekbwru6x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org> <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org> <20050525090616.GB27025@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed May 25 22:37:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db2cG-0004F2-MM
	for gcvg-git@gmane.org; Wed, 25 May 2005 22:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVEYUho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEYUho
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 16:37:44 -0400
Received: from main.gmane.org ([80.91.229.2]:53720 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261541AbVEYUhi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 16:37:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Db2ZN-0003oJ-7J
	for git@vger.kernel.org; Wed, 25 May 2005 22:33:37 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 May 2005 22:33:37 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 May 2005 22:33:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Ingo Molnar wrote:

> But if someone has a strong math background
> (Junio?) then the "1 < x < 5" syntax could be the natural thing he got
> used to.

Or Python -- and I assume there are more languages where this idiom works
correctly.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


