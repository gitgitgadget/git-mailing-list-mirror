From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git-diff-tree rename detection bug
Date: Fri, 16 Sep 2005 14:53:24 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.16.12.53.23.881501@smurf.noris.de>
References: <59a6e583050914094777c4fe96@mail.gmail.com> <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net> <59a6e583050914114054b1564d@mail.gmail.com> <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org> <17192.56103.803096.526568@cargo.ozlabs.ibm.com> <43290DA0.3030402@zytor.com> <Pine.LNX.4.58.0509150739460.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 16 15:00:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGFn2-0001kI-1d
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 14:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbVIPM6B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 08:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVIPM6A
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 08:58:00 -0400
Received: from main.gmane.org ([80.91.229.2]:934 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161083AbVIPM6A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 08:58:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EGFkV-0000or-1V
	for git@vger.kernel.org; Fri, 16 Sep 2005 14:55:27 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 14:55:27 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 14:55:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8681>

Hi, Linus Torvalds wrote:

> I'm not seeing that as a high priority. Maybe in five years ;)

Hmm. Just for comparison, how long was the time between "this will never
run on anything but i386" and "mkdir arch/alpha"? ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
...He who laughs does not believe in what he laughs at, but neither
does he hate it.  Therefore, laughing at evil means not preparing oneself to
combat it, and laughing at good means denying the power through which good is
self-propagating.
		-- Umberto Eco, "The Name of the Rose"
