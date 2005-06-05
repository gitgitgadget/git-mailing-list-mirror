From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make git-update-cache --force-remove regular
Date: Sun, 5 Jun 2005 16:58:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506051657540.1876@ppc970.osdl.org>
References: <20050531165243.GD7013@pasky.ji.cz> <20050605232620.GU17462@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 01:52:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df4uw-0002Fa-ID
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 01:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFEX4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 19:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVFEX4F
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 19:56:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:6822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbVFEX4D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 19:56:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j55Nu0jA032057
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 16:56:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j55NtxWM029741;
	Sun, 5 Jun 2005 16:56:00 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050605232620.GU17462@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005, Petr Baudis wrote:
> 
> Can this go in, please? Currently it's the only delta between your and
> my git tree, so I'd like to get it merged so that Cogito works with
> stock git again.

Done.

		Linus
