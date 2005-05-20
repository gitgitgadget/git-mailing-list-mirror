From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 23:41:07 +0200
Message-ID: <1116625268.12975.103.camel@dhcp-188>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
	 <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>
	 <1116611932.12975.22.camel@dhcp-188>
	 <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>
	 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>
	 <1116615600.12975.33.camel@dhcp-188>
	 <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri May 20 23:44:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZFET-0002Hl-KF
	for gcvg-git@gmane.org; Fri, 20 May 2005 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVETVlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVETVlb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 17:41:31 -0400
Received: from soundwarez.org ([217.160.171.123]:61154 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261356AbVETVlZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 17:41:25 -0400
Received: from dhcp-188.off.vrfy.org (d027239.adsl.hansenet.de [80.171.27.239])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 26A0539179;
	Fri, 20 May 2005 23:41:23 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-20 at 12:22 -0700, Linus Torvalds wrote:
> 
> On Fri, 20 May 2005, Kay Sievers wrote:
> > 
> > Somehting like this?:
> >   http://kernel.org/git/?p=git/git.git;a=commitdiff;h=de809dbbce497e0d107562615c1d85ff35b4e0c5
> 
> Btw, at least for me, this looks much more interesting than the "commit" 
> thing, and maybe it would make sense to make the summary links be to the 
> "commitdiff" instead of the "commit"?

How about this:
  http://www.kernel.org/git/?p=git/git.git;a=summary

The default link is still the same, but you can use the link at the end.

Kay

