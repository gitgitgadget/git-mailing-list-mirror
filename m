From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: The coolest merge EVER!
Date: Fri, 24 Jun 2005 13:54:52 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.24.11.54.51.598627@smurf.noris.de>
References: <Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org> <7v64w4d1n6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jun 24 13:54:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlmkj-0005bq-Bs
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 13:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbVFXL7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 07:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVFXL7D
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 07:59:03 -0400
Received: from main.gmane.org ([80.91.229.2]:62633 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263275AbVFXLzH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 07:55:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dlmfb-0004Q3-N6
	for git@vger.kernel.org; Fri, 24 Jun 2005 13:48:28 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 13:48:27 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 13:48:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Junio C Hamano wrote:

> I suspect there
> would be a massive additional support needed if you want to make it easy
> for Paul to pull changes made to gitk in your tree.

I don't think that's possible; after all, the trees are now merged, so any
pull would fetch all of Linus' tree.

Paul could do it as patches, or Linus could do it in a branch, or we could
write something entirely different from git that happens to support
cherrypicking. ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
What's so funny 'bout peace, love, and understanding?


