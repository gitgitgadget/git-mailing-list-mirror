From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Thu, 12 May 2005 23:00:26 +0200
Message-ID: <1115931627.8465.6.camel@dhcp-188.off.vrfy.org>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <7v3bssfbsj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:54:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKg1-0002ux-OZ
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVELVAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVELVAk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:00:40 -0400
Received: from soundwarez.org ([217.160.171.123]:3778 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262118AbVELVAc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 17:00:32 -0400
Received: from dhcp-188.off.vrfy.org (c211149.adsl.hansenet.de [213.39.211.149])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 168A61F969;
	Thu, 12 May 2005 23:00:31 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bssfbsj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 13:07 -0700, Junio C Hamano wrote:
> * [Previous page] [Next page] would be nice in addition to last
>   10, day, week, etc.

That should be easy to do with the parameters we have now for the
git-rev-list. I will first finish the new browser through the
trees/files, then the project overview page and after that try the
pager,

> * Putting the commit headline and "X hour"s ago in a separate
>   div or span next to each other, so that a long commit headline
>   wraps properly and does not start the second line just under
>   the "X hours ago" timestamp would be nicer (you can see what I
>   mean easily by narrowing the browser window).

Block elements (div) are not allowed inside an a-tag in XHTML/Strict -
don't know how to do this, cause the whole headline should be a link
without the use of javascript. :)

Thanks,
Kay

