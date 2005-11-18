From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Fri, 18 Nov 2005 18:57:53 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.18.17.57.52.158522@smurf.noris.de>
References: <20051117193714.428785C7FA@nox.op5.se> <7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Nov 20 21:52:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edw8X-0004R0-S9
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 21:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVKTUuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 15:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKTUuF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 15:50:05 -0500
Received: from main.gmane.org ([80.91.229.2]:60037 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932085AbVKTUuE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 15:50:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Edw6M-0003ki-GB
	for git@vger.kernel.org; Sun, 20 Nov 2005 21:47:54 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:47:54 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Nov 2005 21:47:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12400>

Hi, Andreas Ericsson wrote:

> DWIM? That's an acronym I don't know.

"Do What I Mean".

It's actually meant to be DMNS ("Do what i Mean, Not what i Say"),
but some early AI hackers at MIT shortened it maliciously so that
they could claim at least *some* success.  :-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
do you want my self-identities alphabetically, chronologically, or in
random order?  -- Misha
