From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-rev-list(1): group options; reformat; document more
 options
Date: Thu, 31 Aug 2006 16:02:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608311557470.27779@g5.osdl.org>
References: <20060831223715.GC482@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 01:03:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvZ5-0003gg-IG
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWHaXDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 19:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHaXDM
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 19:03:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932227AbWHaXDL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 19:03:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7VN32nW008006
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 31 Aug 2006 16:03:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7VN2u5p028279;
	Thu, 31 Aug 2006 16:02:59 -0700
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060831223715.GC482@diku.dk>
X-Spam-Status: No, hits=-2.441 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26285>



On Fri, 1 Sep 2006, Jonas Fonseca wrote:
>
> An attempted facelift to the neglected git-rev-list manpage. One
> question if I may, the diff-related -r and -t options, how are they
> supposed to work?

Umm? You should get a "usage" error, no?

		Linus
