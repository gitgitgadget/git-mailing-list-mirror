From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 14:13:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704171412020.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <200704172012.31280.andyparkins@gmail.com> <Pine.LNX.4.64.0704171229360.5473@woody.linux-foundation.org>
 <200704172146.33665.andyparkins@gmail.com> <Pine.LNX.4.64.0704171405060.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduzS-00054N-TX
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031243AbXDQVN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031252AbXDQVN1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:13:27 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36910 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031243AbXDQVN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:13:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HLDMC0018027
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 14:13:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HLDKH1008094;
	Tue, 17 Apr 2007 14:13:21 -0700
In-Reply-To: <Pine.LNX.4.64.0704171405060.5473@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44827>



On Tue, 17 Apr 2007, Linus Torvalds wrote:
> 
> Windows we cannot change. CVS users we can try to help. 

.. and if it wasn't clear, "helping" CVS users is not in my opinion to try 
to make git act like CVS, and lettign them do stupid things, but to try to 
help them become *more* than CVS users.

Because they too can become upstanding members of society, and leave their 
dark past behind them. I firmly believe that nobody is past saving.

		Linus
