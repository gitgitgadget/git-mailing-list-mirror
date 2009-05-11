From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: use --textconv to generate diff text
Date: Tue, 12 May 2009 07:59:37 +1000
Message-ID: <18952.40905.302916.243355@cargo.ozlabs.ibm.com>
References: <4A07D160.9020709@viscovery.net>
	<20090511091346.GA5685@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 11 23:59:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3dXO-0000vk-1U
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 23:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbZEKV7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 17:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbZEKV7m
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 17:59:42 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:39825 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbZEKV7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 17:59:42 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 307D1B7069; Tue, 12 May 2009 07:59:43 +1000 (EST)
In-Reply-To: <20090511091346.GA5685@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118853>

Jeff King writes:

> As the original author of the textconv code, I am in favor of this. So
> much so that I even posted basically the same patch before:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/102523
> 
> I had trouble finding much discussion in the archive, but I think it may
> not have been taken because we were in release freeze (and textconv was
> a brand new feature in the release at the time).

Which release did --textconv first appear in?

Paul.
