From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 10:29:18 -0500
Message-ID: <8A7AFC0A-470D-4386-A8BD-7DAFEF4E95CD@silverinsanity.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>	<87ps9d7j6t.fsf@morpheus.local>	<7vejptsglj.fsf@assigned-by-dhcp.cox.net>	<625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>	<7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>	<7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>	<81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net> <45AF6AC6.2060206@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Josh Boyer <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 16:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZCg-0002qh-J6
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbXARP3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbXARP3Z
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:29:25 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:57041 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbXARP3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:29:24 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 7928A1FFD0EE;
	Thu, 18 Jan 2007 15:29:22 +0000 (UTC)
In-Reply-To: <45AF6AC6.2060206@op5.se>
To: Andreas Ericsson <ae@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37108>


On Jan 18, 2007, at 7:40 AM, Andreas Ericsson wrote:

> Junio C Hamano wrote:
>> Is it common for popular MUAs to have a single command that lets
>> you specify a file and depending on its suffix paste it inline
>> or make it an attachment?  I had an impression that most have
>> separate commands for "read text from file (as opposed to
>> typing)" and "attach a file (of random type, not necessarily and
>> more often than not text)".
>
> Most have only "attach" through various means of point-and-click  
> and drag-and-drop. Thunderbird too lacks the very basic ability of  
> "include this file as part of the message". I still haven't been  
> able to find an addon for it that does just that.

The "easiest" way is to open it in an editor and Copy'n'Paste it into  
the message.  Unfortunately, not all clipboards or applications can  
be trusted not to mangle whitespace.  I learned that the hard way  
trying to use Mail.app to send out patches.  I ended up just  
installing Mutt.  Perhaps I should figure out how this "git-send- 
email" works, although it doesn't appear to support authentication...

~~ Brian
