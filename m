From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 12:11:40 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.20.10.11.38.565694@smurf.noris.de>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <7vy85s9tgk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 20 12:17:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHfAZ-000287-OK
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 12:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVITKQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 06:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVITKQI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 06:16:08 -0400
Received: from main.gmane.org ([80.91.229.2]:32489 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964960AbVITKQG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 06:16:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHf8B-0001VP-87
	for git@vger.kernel.org; Tue, 20 Sep 2005 12:13:43 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2005 12:13:43 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2005 12:13:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8988>

Hi, Junio C Hamano wrote:

> I would imagine a gitk graph with nodes colored red for commits
> with last week's timestamps,

One feature I'd like to see in this context is a gitk tree view that lists
nodes in date order, instead of the "walk down one branch as far as
possible before doing the next one" process it currently uses.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
How often I found where I should be going only by setting out for somewhere
else.
		-- R. Buckminster Fuller
