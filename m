From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Documentation for git-log --follow
Date: Thu, 12 Jul 2007 11:48:35 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707121147050.20061@woody.linux-foundation.org>
References: <20070712145230.GA21590@dervierte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:49:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93is-0005cx-Uw
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402AbXGLSsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756026AbXGLSsy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:48:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51636 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756212AbXGLSsx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 14:48:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CImfJg013481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2007 11:48:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CImZuH026948;
	Thu, 12 Jul 2007 11:48:35 -0700
In-Reply-To: <20070712145230.GA21590@dervierte>
X-Spam-Status: No, hits=-4.611 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52320>



On Thu, 12 Jul 2007, Steven Walter wrote:
>
> It would appear that Linus didn't add write and docs for this feature 
> when he wrote it.

I am shocked. *Shocked* I say.

Oh, actually, no I'm not. Par for the course for me. Sorry.

It might be worth documenting that unline all the other log commands, 
--follow requires exactly one pathname. Maybe it's obvious.

		Linus
