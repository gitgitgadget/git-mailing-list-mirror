From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 16:03:32 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.24.14.03.31.13115@smurf.noris.de>
References: <867jc336f4.fsf@blue.stonehenge.com> <7v64rnsd83.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Oct 24 16:11:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU30k-0001Cm-Iy
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 16:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVJXOJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 10:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVJXOJL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 10:09:11 -0400
Received: from main.gmane.org ([80.91.229.2]:2260 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751041AbVJXOJK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 10:09:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EU2yS-0000PS-7N
	for git@vger.kernel.org; Mon, 24 Oct 2005 16:06:52 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Oct 2005 16:06:52 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Oct 2005 16:06:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10542>

Hi, Junio C Hamano wrote:

> Maybe something like this would help?

I agree that this change, though intrusive, is a good idea.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The thing I like best about Spider-Man is that there's a hyphen in the
title. -- SJM's review of the movie
