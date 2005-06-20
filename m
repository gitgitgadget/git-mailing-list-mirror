From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 15:48:31 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.20.13.48.30.2680@smurf.noris.de>
References: <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org> <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org> <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org> <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org> <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org> <20050620123053.GI15021@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jun 20 15:53:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkMhx-0002XB-Eq
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 15:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFTN6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 09:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVFTN5d
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 09:57:33 -0400
Received: from main.gmane.org ([80.91.229.2]:47835 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261252AbVFTN51 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 09:57:27 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DkMfc-0001bK-LJ
	for git@vger.kernel.org; Mon, 20 Jun 2005 15:50:36 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 15:50:36 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 15:50:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Jens Axboe wrote:

> error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
> bad object in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c

What does "git-cat-file -t" say on these two -- are they botth vald commit
objects?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
He that is giddy thinks the world turns round.
		-- William Shakespeare, "The Taming of the Shrew"


