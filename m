From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: SVN import issue
Date: Sat, 10 Sep 2005 18:23:13 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.10.16.23.07.865934@smurf.noris.de>
References: <pan.2005.08.26.10.40.38.616149@smurf.noris.de> <m3fysuodbg.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Sep 10 18:27:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EE8As-0005B2-EW
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 18:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVIJQZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 12:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVIJQZs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 12:25:48 -0400
Received: from main.gmane.org ([80.91.229.2]:5015 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750839AbVIJQZr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2005 12:25:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EE89Z-0004qa-9u
	for git@vger.kernel.org; Sat, 10 Sep 2005 18:24:33 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Sep 2005 18:24:33 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Sep 2005 18:24:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8255>

Hi, James Cloos wrote:

> Matthias> Paths in SVN are usually prefixed "/trunk/" (main branch) or
> Matthias> "/branches/foo/" (branch foo); tagging is done by creating
> Matthias> "/tags/bar", with the trunk (or branch) revision it is
> Matthias> pointing to as its parent.
> 
> Anyone working on this should note that /usually/ is vital above.

Thanks; I'll keep that in mind. 

Is it common (possible?) to have more than one of these?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
There is no distinctly American criminal class except Congress.
	-- Mark Twain
