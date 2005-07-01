From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: cvsimport: rewritten in Perl
Date: Fri, 01 Jul 2005 11:43:34 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.01.09.43.24.106822@smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 01 11:37:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoHxM-0001cO-4R
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 11:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbVGAJol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 05:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbVGAJol
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 05:44:41 -0400
Received: from main.gmane.org ([80.91.229.2]:55267 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263295AbVGAJoj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 05:44:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DoHwx-0001a5-62
	for git@vger.kernel.org; Fri, 01 Jul 2005 11:36:43 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2005 11:36:43 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2005 11:36:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Nicolas Pitre wrote:

> On Thu, 30 Jun 2005, Matthias Urlichs wrote:
> 
>> Duh. Will post an incremental patch shortly.
> 
> Until Linus merges it I'd suggest that you post the updated full patch 
> instead.

Personally, I'd prefer merging.

Linus/everybody_else  :-) : Please pull from

rsync://netz.smurf.noris.de/git.git#cvs2git

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
We were hungry when we got to Moscow, Soviet.
					-- Groucho Marx
