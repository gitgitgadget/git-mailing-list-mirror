From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Template files location
Date: Thu, 11 Aug 2005 00:03:40 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.10.22.03.39.544630@smurf.noris.de>
References: <42DC4537.2080103@orionmulti.com> <20050805024222.GE7762@shell0.pdx.osdl.net> <42F2E571.6040207@orionmulti.com> <7voe8dow4w.fsf@assigned-by-dhcp.cox.net> <20050805042332.GG7762@shell0.pdx.osdl.net> <7vd5otov7s.fsf@assigned-by-dhcp.cox.net> <20050805094324.GF29216@pasky.ji.cz> <7vpsssjnld.fsf@assigned-by-dhcp.cox.net> <42F3A6E5.2070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 11 00:07:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2yiF-0008LP-PL
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 00:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVHJWGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 18:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVHJWGN
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 18:06:13 -0400
Received: from main.gmane.org ([80.91.229.2]:10466 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932376AbVHJWGM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 18:06:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E2yh8-0008Cy-GQ
	for git@vger.kernel.org; Thu, 11 Aug 2005 00:05:06 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 00:05:06 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 00:05:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, A Large Angry SCM wrote:

> Rather than changing the default install location in such a way as to make
> half the user unhappy, make everybody (un)happy by removing the default
> and forcing it to be specified when make is executed.

Lots of stuff installs to /usr/local if not stated otherwise.
I don't see why git should be different.

Why make *everybody* unhappy if we can avoid it?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Grain grows best in shit
		-- U. K. LeGuin
