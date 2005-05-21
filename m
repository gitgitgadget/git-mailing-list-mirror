From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: cvs->git (was Re: gitweb wishlist)
Date: Sat, 21 May 2005 09:35:30 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.05.21.07.35.29.758035@smurf.noris.de>
References: <20050511012626.GL26384@pasky.ji.cz> <1116384951.5094.83.camel@dhcp-188.off.vrfy.org> <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org> <1116611932.12975.22.camel@dhcp-188> <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188> <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org> <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat May 21 09:36:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZOWM-0003KQ-BE
	for gcvg-git@gmane.org; Sat, 21 May 2005 09:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVEUHgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 03:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVEUHgb
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 03:36:31 -0400
Received: from main.gmane.org ([80.91.229.2]:61582 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261693AbVEUHgS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 03:36:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DZOVO-0003GC-EX
	for git@vger.kernel.org; Sat, 21 May 2005 09:34:42 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 May 2005 09:34:42 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 May 2005 09:34:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Linus Torvalds wrote:

> Bah. What crud.

I have an old CVS->BK merge script lying around which does all of this
reasonably correctly. If somebody wants to git-ify it, be my guest
(I won't have time in the foreseeable futurre :-( ); it's in the
rsync://server.smurf.noris.de/sourcemgr.git/#main repository as
bin/b.cvs{,.pl}.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


