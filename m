From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cg-cat   [was: Re: Newbie question:  equiv of:  cvs co -p <filename>  ? ]
Date: Fri, 12 Aug 2005 09:53:12 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.12.07.53.11.741187@smurf.noris.de>
References: <ddb8vl$ifq$1@sea.gmane.org> <Pine.LNX.4.58.0508091725120.3258@g5.osdl.org> <42FA1150.7090506@research.att.com> <20050811230343.GJ25280@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Aug 12 09:58:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3UPK-0002Tb-12
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 09:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVHLH4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 03:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVHLH4p
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 03:56:45 -0400
Received: from main.gmane.org ([80.91.229.2]:17569 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750938AbVHLH4o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 03:56:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E3UMm-0002Gf-CY
	for git@vger.kernel.org; Fri, 12 Aug 2005 09:54:12 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Aug 2005 09:54:12 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Aug 2005 09:54:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Petr Baudis wrote:

>         cg-admin-cat       [-r TREE_ID] FILE...
>         cg-admin-ls        [-t TREE_ID] [PATH]

I don't know if these need to be merged, *but* please at least
change one of the flag names so that the whole mess is slightly more
consistent.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The thought of 2000 thousand people munching celery at the same time
horrifies me.
					-- George Bernard Shaw
