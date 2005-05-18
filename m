From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Wed, 18 May 2005 04:55:51 +0200
Message-ID: <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
References: <20050511012626.GL26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 04:56:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYEil-0003nN-To
	for gcvg-git@gmane.org; Wed, 18 May 2005 04:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVERC4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 22:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVERC4H
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 22:56:07 -0400
Received: from soundwarez.org ([217.160.171.123]:40158 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262061AbVERC4A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 22:56:00 -0400
Received: from dhcp-188.off.vrfy.org (d053109.adsl.hansenet.de [80.171.53.109])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 37D8F2C741;
	Wed, 18 May 2005 04:55:58 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511012626.GL26384@pasky.ji.cz>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 03:26 +0200, Petr Baudis wrote:

>   I think I would prefer the link from the repository index to go not to
> the log page, but some "summary" page, which would have some short
> information about the repository (owner, description, list of branches
> if gitweb supports that, list of tags, link to the latest tree and link
> to the log).

I did this now. The top-link shows now the repository listing with a
nice "last change" field. The default link points to an overview page
which also list the tags.
(The owner filed in that list is not correct until now, cause the
cron-job needs to be adapted.)

Thanks,
Kay

