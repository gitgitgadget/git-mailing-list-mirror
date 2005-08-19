From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: SVN import
Date: Fri, 19 Aug 2005 12:00:51 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.19.10.00.49.401829@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Aug 19 12:04:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E63iZ-0003V4-5V
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 12:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVHSKDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 06:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVHSKDF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 06:03:05 -0400
Received: from main.gmane.org ([80.91.229.2]:14289 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932464AbVHSKDE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 06:03:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E63h7-00039A-4s
	for git@vger.kernel.org; Fri, 19 Aug 2005 12:01:49 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Aug 2005 12:01:49 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Aug 2005 12:01:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Quick note: I'm working on importing from SVN.

My current main problem is that SVN's Perl interface leaks server
connections (apparently nobody has used it for any real work yet),
which is of course *bad*, and kindof prevents me from finishing
the job today. :-/

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I could certainly run a marvellous university here if only we didn't
have to have all these damn students underfoot all the time.
		-- Terry Pratchett (Hogfather)
