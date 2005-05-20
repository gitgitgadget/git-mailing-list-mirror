From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 21:00:00 +0200
Message-ID: <1116615600.12975.33.camel@dhcp-188>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
	 <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>
	 <1116611932.12975.22.camel@dhcp-188>
	 <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>
	 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 21:01:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZCiY-0007UU-RP
	for gcvg-git@gmane.org; Fri, 20 May 2005 20:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVETTAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 15:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVETTAY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 15:00:24 -0400
Received: from soundwarez.org ([217.160.171.123]:24284 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261550AbVETTAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 15:00:17 -0400
Received: from dhcp-188.off.vrfy.org (d027239.adsl.hansenet.de [80.171.27.239])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 383805C61;
	Fri, 20 May 2005 21:00:15 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-20 at 11:28 -0700, Linus Torvalds wrote:
> 
> On Fri, 20 May 2005, Linus Torvalds wrote:
> >
> > Looking good.
> 
> Oh, dang, while I'm at it, why not ask for the "commmitdiff" thing to have 
> the commit message in it too, ie basically look like a prettified version 
> of "git-diff-tree -v -M <cmitname>"
> 
> You already do the first line of it, so there's not much missing. Right
> now there is no place where everything important from one commit is
> "brought together" (ie no single place where you can see both what the
> diff is all about, and what it actually does).

Somehting like this?:
  http://kernel.org/git/?p=git/git.git;a=commitdiff;h=de809dbbce497e0d107562615c1d85ff35b4e0c5

Kay

