From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fix bogus "diff --git" header from "diff --no-index"
Date: Sun, 5 Oct 2008 13:40:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810051333110.3208@nehalem.linux-foundation.org>
References: <20081005193515.GA29022@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 05 22:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmaQr-0006st-O7
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 22:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbYJEUlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbYJEUlI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 16:41:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45741 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502AbYJEUlG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Oct 2008 16:41:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m95KeO6m016894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Oct 2008 13:40:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m95KeORL017033;
	Sun, 5 Oct 2008 13:40:24 -0700
In-Reply-To: <20081005193515.GA29022@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.434 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97534>



On Sun, 5 Oct 2008, Jeff King wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Signed-off-by: Jeff King <peff@peff.net>

Tests and explanation looks fine, so you can add my Signed-off-by: too..

	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

		Linus
