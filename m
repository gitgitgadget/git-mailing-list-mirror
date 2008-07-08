From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [take 2] revision parsing made incremental
Date: Tue, 8 Jul 2008 10:41:47 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807081041310.11076@woody.linux-foundation.org>
References: <1215523175-28436-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGHDy-0005A2-73
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 19:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbYGHRmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYGHRmg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 13:42:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43426 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753422AbYGHRmf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 13:42:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m68Hfmf3000802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jul 2008 10:41:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m68HflSr026903;
	Tue, 8 Jul 2008 10:41:47 -0700
In-Reply-To: <1215523175-28436-1-git-send-email-madcoder@debian.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.86 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87777>



On Tue, 8 Jul 2008, Pierre Habouzit wrote:
> 
> The series passes the testsuite, has no know blanks issues, and is
> pushed to my public repository.

Ack. Looks good to me.

		Linus
