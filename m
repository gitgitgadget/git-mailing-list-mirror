From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: omitted test scripts?
Date: Mon, 19 Sep 2005 20:54:39 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.19.18.54.38.742376@smurf.noris.de>
References: <200509102027.28812.blaisorblade@yahoo.it> <1126427087.8457.33.camel@localhost.localdomain> <200509142019.04667.blaisorblade@yahoo.it> <tnxslw6d4qt.fsf@arm.com> <7vvf10hji1.fsf@assigned-by-dhcp.cox.net> <1126949517.6941.19.camel@localhost.localdomain> <432EDE3F.7070407@citi.umich.edu> <7v1x3lrpxi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Sep 19 21:01:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHQqt-0007mF-4x
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 20:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVISS6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 14:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVISS6v
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 14:58:51 -0400
Received: from main.gmane.org ([80.91.229.2]:48064 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932577AbVISS6u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 14:58:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHQod-0006zk-JO
	for git@vger.kernel.org; Mon, 19 Sep 2005 20:56:35 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 20:56:35 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 20:56:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8894>

Hi, Junio C Hamano wrote:

> In the past, when I did any major butchering of existing code or
> made nontrivial additions, I wrote test scripts to cover what
> should happen (and what to be preserved) first to make sure the
> changes or additions would not introduce regression.

... which is very good programming practice regardless.

One of the better tenets of Extreme Programming says that any feature
for which you don't have a test basically doesn't exist. 

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Buddha most emphatically insists that what he teaches is nothing
unusual, being simply the recognition of a plain fact which can be
attested to by every mortal...
