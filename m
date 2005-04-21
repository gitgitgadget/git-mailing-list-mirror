From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Docs update
Date: Fri, 22 Apr 2005 00:10:23 +0100
Message-ID: <426832DF.4090909@dgreaves.com>
References: <42680FCC.6030901@dgreaves.com> <7vy8bbd9n4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 01:07:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkks-0003kr-Nz
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 01:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVDUXK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 19:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVDUXK4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 19:10:56 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:56238 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261706AbVDUXK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 19:10:29 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A2B80E6D5C; Fri, 22 Apr 2005 00:08:32 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13624-09; Fri, 22 Apr 2005 00:08:32 +0100 (BST)
Received: from oak.dgreaves.com (modem-2040.lynx.dialup.pol.co.uk [217.135.199.248])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 0B2C1E6A86; Fri, 22 Apr 2005 00:08:32 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DOkoR-0002qF-T4; Fri, 22 Apr 2005 00:10:23 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Junio C Hamano <junio@siamese.dyndns.org>
In-Reply-To: <7vy8bbd9n4.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"DG" == David Greaves <david@dgreaves.com> writes:
> Looks nice.  I agree with Petr's comment that separating core part
> and Cogito part would be good
OK


> And the option to use working tree is not having the --cached
> flag you describe later.  Please also update the usage at the
> top as well:
<snip>
> This command can take commit ID in place of tree ID.

Yep, the intention is to do all the core docs, get consistent use of 
<sha1> or <tree> or <id> etc etc and then patch all the usage()s at once.

Thanks for the comments - will edit in the am.

David
