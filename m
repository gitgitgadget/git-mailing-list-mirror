From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sat, 14 Apr 2007 21:48:42 -0400
Message-ID: <0D85864F-E9E9-4F22-93E6-B5B8F9A6C383@silverinsanity.com>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net> <200704131033.15751.andyparkins@gmail.com> <7vejmm78qp.fsf@assigned-by-dhcp.cox.net> <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 03:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HctrZ-00020l-6b
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 03:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXDOBss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 21:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbXDOBss
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 21:48:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59155 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbXDOBss (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 21:48:48 -0400
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3BB721FFC01F;
	Sun, 15 Apr 2007 01:48:47 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44481>


On Apr 14, 2007, at 9:41 PM, Linus Torvalds wrote:

> (Side thought - I have to concur with whoever suggested "-" instead of
> "!". It just reads better, I think)

The "diff" vs "nodiff" argument reminds me of Vim option setting.   
Marking a path "diff" means a diff is useful.  Marking it "nodiff"  
marks it non-useful, same with "crlf" and "nocrlf".  Just an idea to  
throw out there.  It's fairly unambiguous.

~~ Brian G.
