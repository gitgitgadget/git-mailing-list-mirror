From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Add git-name-rev
Date: Thu, 27 Oct 2005 10:53:19 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.27.08.53.17.258926@smurf.noris.de>
References: <Pine.LNX.4.63.0510260103570.27364@wbgn013.biozentrum.uni-wuerzburg.de> <20051026083625.GD30889@pasky.or.cz> <Pine.LNX.4.63.0510261509060.31868@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 27 11:04:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV3eR-0007of-5A
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 11:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVJ0JCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 05:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbVJ0JCU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 05:02:20 -0400
Received: from main.gmane.org ([80.91.229.2]:33153 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965014AbVJ0JCT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 05:02:19 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EV3dN-0007QS-E3
	for git@vger.kernel.org; Thu, 27 Oct 2005 11:01:17 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 11:01:17 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 11:01:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10705>

Hi, Johannes Schindelin wrote:

> [PATCH] Add git-name-rev

Please update the "git" manpage when you add a new command.
(I bet that others are missing too..?)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Let the machine do the dirty work.
		-- "Elements of Programming Style", Kernighan and Ritchie
