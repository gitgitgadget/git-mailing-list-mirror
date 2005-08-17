From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Add merge detection to git-cvsimport
Date: Wed, 17 Aug 2005 19:29:28 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.17.17.29.26.687298@smurf.noris.de>
References: <20050816103527.F420A33010C@ng.eduforge.org> <20050816110725.GL11882MdfPADPa@garage.linux.student.kuleuven.ac.be> <46a038f9050816143646fa4137@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Aug 17 19:34:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Rlv-0002Rh-4r
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 19:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVHQRb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVHQRb6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 13:31:58 -0400
Received: from main.gmane.org ([80.91.229.2]:26500 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751181AbVHQRb5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 13:31:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5RkL-00025t-VL
	for git@vger.kernel.org; Wed, 17 Aug 2005 19:30:37 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 19:30:37 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 19:30:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Martin Langhoff wrote:

> this one is the
> most likely one to be from a bug in cvsps or the cvsimport logic.

That's not a bug in the import logic, just a failure of the CVS-merging
person to be consistent. (Which is hardly news. :-/ )

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Reason:
	Bad, toxic entity, that foolish people use when they ought to use
	their inner voice, or angels, or intuition, or a gut feeling, or
	their hearts, or the I Ching.
		-- Fashionable Dictionary (www.butterfliesandwheels.com)
