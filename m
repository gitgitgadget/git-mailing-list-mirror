From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Thu, 12 May 2005 14:18:32 -0700
Message-ID: <7vy8akdtxz.fsf@assigned-by-dhcp.cox.net>
References: <20050511012626.GL26384@pasky.ji.cz>
	<7v3bssfbsj.fsf@assigned-by-dhcp.cox.net>
	<1115931627.8465.6.camel@dhcp-188.off.vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 23:13:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKyj-0005i7-91
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVELVTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVELVTl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:19:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52215 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262127AbVELVSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 17:18:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512211834.TCIV26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 17:18:34 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1115931627.8465.6.camel@dhcp-188.off.vrfy.org> (Kay Sievers's
 message of "Thu, 12 May 2005 23:00:26 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

>> * Putting the commit headline and "X hour"s ago in a separate
>> div or span next to each other, so that a long commit headline
>> wraps properly and does not start the second line just under
>> the "X hours ago" timestamp would be nicer (you can see what I
>> mean easily by narrowing the browser window).

KS> Block elements (div) are not allowed inside an a-tag in XHTML/Strict -
KS> don't know how to do this,...

Wouldn't splitting the commit headline and "X hours ago" into
two separate elements and wrap them individually inside an a-tag
each pointing at the same destination good enough then?

