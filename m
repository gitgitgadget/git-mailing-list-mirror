From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Thu, 29 Sep 2005 06:40:14 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.29.04.40.14.655977@smurf.noris.de>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net> <87psqwzs3x.fsf@ualberta.net> <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net> <20050926191037.GD26340@pasky.or.cz> <7vll1jh8zr.fsf@assigned-by-dhcp.cox.net> <20050927101744.GD30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Sep 29 06:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKqKh-00053W-8M
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVI2Ero (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVI2Ero
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:47:44 -0400
Received: from main.gmane.org ([80.91.229.2]:30633 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751191AbVI2Ern (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 00:47:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EKqHL-0004YB-JF
	for git@vger.kernel.org; Thu, 29 Sep 2005 06:44:20 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 06:44:19 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 06:44:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9459>

Hi, Petr Baudis wrote:

> However, I still think
> that the user should be required to specify the to-be-merged head manually
> if the default choice isn't explicitly written in the remotes file.

I tend to agree -- intentional octopus merges are rare enough.
For most people, anyway. ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
It is not a good omen when goldfish commit suicide.
