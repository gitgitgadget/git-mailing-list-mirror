From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Fix 'git add' with .gitignore (Re: git-add ignores .gitignore)
Date: Fri, 29 Dec 2006 23:42:32 -0500
Message-ID: <8D9102A3-C5A7-40B7-AE11-EE091A516775@silverinsanity.com>
References: <033682AF-B324-4049-B331-8A8AF2335E4D@silverinsanity.com> <7vpsa2msx2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 05:42:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0W3N-0000hq-BJ
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 05:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWL3Emg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 23:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWL3Emf
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 23:42:35 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:40686 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030272AbWL3Emf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 23:42:35 -0500
Received: from [192.168.0.2] (cpe-69-204-218-82.stny.res.rr.com [69.204.218.82])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id AD5901FFC02B;
	Sat, 30 Dec 2006 04:42:34 +0000 (UTC)
In-Reply-To: <7vpsa2msx2.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35613>


On Dec 29, 2006, at 1:57 PM, Junio C Hamano wrote:

> Thanks for noticing.

Hard not to.  Git suddenly tried to add a couple hundred files from a  
library I don't want to track.  ;-)

> How about this patch, after you revert that commit?

I'm on vacation at my in-laws, so I'll try it when I get a chance but  
it may take a few days.  (I'm only checking e-mail and that's just so  
I'm not buried in git list mails on Tuesday.

~~ Brian
