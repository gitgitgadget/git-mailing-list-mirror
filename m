From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Sun, 31 Jul 2005 11:36:10 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.31.09.36.07.97284@smurf.noris.de>
References: <11227978451100@foobar.com> <20050731082430.GG32263@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 31 11:37:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzAFN-0005Sx-LA
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 11:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVGaJgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 05:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVGaJgf
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 05:36:35 -0400
Received: from main.gmane.org ([80.91.229.2]:37275 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261551AbVGaJge (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 05:36:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DzAF9-0005SK-RE
	for git@vger.kernel.org; Sun, 31 Jul 2005 11:36:27 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Jul 2005 11:36:27 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Jul 2005 11:36:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Ryan Anderson wrote:

> And yes, I did generate this thread with this script - so I have proof
> that it works nicely.

It might make sense to create a "Patch 0/N" with a short explanation, and
have the actual patches be replies to that -- or to patch 1/N if that's
not necessary.

As it is, patch N hangs off patch N-1 in my email threading view, which
gets slightly cumbersome if N>10.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Nothing makes a person more productive than the last minute.
