From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bisect with history manipulation
Date: Mon, 23 Oct 2006 18:19:56 +0200
Organization: At home
Message-ID: <ehiq2l$lkq$1@sea.gmane.org>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com> <a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com> <BAYC1-PASMTP01856E85F8D54BE3CBF69EAE000@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 23 18:21:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc2Xd-0006jz-Og
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWJWQUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 12:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWJWQUl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 12:20:41 -0400
Received: from main.gmane.org ([80.91.229.2]:11718 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751359AbWJWQUk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 12:20:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gc2Wy-0006Zk-K0
	for git@vger.kernel.org; Mon, 23 Oct 2006 18:20:04 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 18:20:04 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 18:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29841>

Sean wrote:

> $ patch < patch1

We have git-apply for that (sometimes git-am would work on whole
series of patches).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
