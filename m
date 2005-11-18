From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 19:07:39 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.18.18.07.37.819505@smurf.noris.de>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org> <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org> <Pine.LNX.4.64.0511171520390.13959@g5.osdl.org> <20051118121210.GA19714@abridgegame.org> <Pine.LNX.4.63.0511181419340.28109@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0511180806550.25159@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Nov 20 21:58:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdwEf-00067U-Gt
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 21:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVKTU4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKTU4T
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 15:56:19 -0500
Received: from main.gmane.org ([80.91.229.2]:906 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750795AbVKTU4S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 15:56:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EdwCJ-0005JK-Ot
	for git@vger.kernel.org; Sun, 20 Nov 2005 21:54:03 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:54:03 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:54:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12401>

Randy.Dunlap wrote:

> ~Randy  [who would just use ISO standard date format]

You can't just use non-confusing dates. 
People used to confusion would be confused.

Speaking of which ..:

Linus Torvalds wrote:
>> 5 months with 73 days each; Chaos, Discord, Confusion, Bureaucracy, The
>>  Aftermath
> I'm sorry, but having "git log --since=confusion" would just be
> irresponsible.
> 
Possibly, but on the other hand there'd be a lot more truth in these than
in our current month names. (November hasn't been the ninth month for
*some* time now...)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
While there's life, there's hope.
		-- Publius Terentius Afer (Terence)
