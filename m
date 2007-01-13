From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 01:36:48 -0500
Message-ID: <B641F998-7DC1-404E-BDB8-7377F8516AB9@silverinsanity.com>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 07:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5cVk-0005uF-QH
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 07:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbXAMGgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 01:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbXAMGgx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 01:36:53 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:46484 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964950AbXAMGgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 01:36:53 -0500
Received: from [192.168.1.3] (cpe-66-67-221-135.rochester.res.rr.com [66.67.221.135])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3579A1FFD296;
	Sat, 13 Jan 2007 06:36:51 +0000 (UTC)
In-Reply-To: <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36740>


On Jan 12, 2007, at 2:43 PM, Junio C Hamano wrote:

> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
> writes:
>
>> Me doesn't really like the new semantics of "git-add", because it  
>> does
>> two seperate things - it adds new files and it refreshes the  
>> content of
>> previously known files.
>
> http://thread.gmane.org/gmane.comp.version-control.git/32452/ 
> focus=32792

Should this be added to Documentation/rants/filename- 
braindamage.txt?  ;-)

~~ Brian
