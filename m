From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Segmentation fault      git read-tree
Date: Thu, 13 Mar 2008 21:26:15 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org>
References: <200803132359.06745.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:27:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1VX-0004mR-8L
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbYCNE0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYCNE0X
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:26:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60807 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751160AbYCNE0X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 00:26:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2E4R9Up009472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Mar 2008 21:27:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2E4QFPW016686;
	Thu, 13 Mar 2008 21:26:15 -0700
In-Reply-To: <200803132359.06745.lenb@kernel.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.356 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77166>



On Thu, 13 Mar 2008, Len Brown wrote:
>
> i pushed the branches necessary to reproduce this right
> before it happened, so you should be able to pull them
> and try it yourself.

Ok, I can reproduce this, I'm on it like a maggot on a two-week-dead baby 
donkey.

		Linus
