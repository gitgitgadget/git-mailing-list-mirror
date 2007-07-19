From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Proposal about --help options and man calls
Date: Wed, 18 Jul 2007 23:49:47 -0400
Message-ID: <4CE1D7B3-23AF-4BED-862C-B225B29E4811@silverinsanity.com>
References: <85y7hdwfds.fsf@lola.goethe.zz> <7v644h715y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 05:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBN1X-0002uN-4c
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 05:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057AbXGSDtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 23:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbXGSDtw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 23:49:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42121 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057AbXGSDtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 23:49:51 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B330A1FFC243;
	Thu, 19 Jul 2007 03:49:50 +0000 (UTC)
In-Reply-To: <7v644h715y.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52931>


On Jul 18, 2007, at 7:16 PM, Junio C Hamano wrote:

> What's the reason to set GIT_PAGER and PAGER differently to
> begin with?  Can people give examples of the reason why?

I currently have GIT_PAGER (actually, core.pager) set to tig.  Tig  
has lots of useful features for visualizing history and jumping  
between patches and logs.

But for everything that isn't git, less is far better.

~~ Brian
