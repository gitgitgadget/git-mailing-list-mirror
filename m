From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: "make test" fails with current HEAD
Date: Thu, 17 Nov 2005 16:31:56 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Nov 17 16:54:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eclvy-00030I-Ps
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 16:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVKQPoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 10:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKQPoT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 10:44:19 -0500
Received: from main.gmane.org ([80.91.229.2]:33440 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751345AbVKQPoS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 10:44:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EclrT-0000se-0v
	for git@vger.kernel.org; Thu, 17 Nov 2005 16:39:43 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 16:39:43 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 16:39:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12122>

t4103.sh:

fatal: patch with only garbage at line 30
* FAIL 7: check binary diff with replacement.
        git-checkout master
                 git-apply --check --allow-binary-replacement BF.diff

May I suggest to please run "make test" before pushing? Thanks! ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
She balanced dignity on the tip of her nose.
