From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH cogito] "cg-whatsnew" command
Date: Sun, 15 May 2005 19:36:37 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.05.15.17.36.37.623874@smurf.noris.de>
References: <tnx64xm5b2b.fsf@arm.com> <20050514110941.GB3905@pasky.ji.cz> <tnx3bsoki2j.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun May 15 19:41:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXN7E-0005p1-Iz
	for gcvg-git@gmane.org; Sun, 15 May 2005 19:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVEORl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 13:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVEORl1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 13:41:27 -0400
Received: from main.gmane.org ([80.91.229.2]:51361 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261168AbVEORlY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 13:41:24 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DXN6c-0005kU-MD
	for git@vger.kernel.org; Sun, 15 May 2005 19:40:46 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 May 2005 19:40:46 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 May 2005 19:40:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Catalin Marinas wrote:

> +	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [-m [BNAME] [BNAME]] [FILE]...

That should be

[-m [BNAME [BNAME]]]

though I'd suggest something more mnemonic than two BNAMEs.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


