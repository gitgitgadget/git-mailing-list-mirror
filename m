From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 06:44:38 -0500
Message-ID: <458A73A6.4010805@garzik.org>
References: <4589F9B1.2020405@garzik.org> <1166680407.3636.25.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 12:44:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxMLw-0002T9-Ox
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWLULop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWLULop
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:44:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41757 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964968AbWLULoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:44:44 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1GxMLp-00008G-PX; Thu, 21 Dec 2006 11:44:42 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: nigel@nigel.suspend2.net
In-Reply-To: <1166680407.3636.25.camel@nigel.suspend2.net>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35057>

Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2006-12-20 at 22:04 -0500, Jeff Garzik wrote:
>> I refreshed my git intro/cookbook for kernel hackers, at 
>> http://linux.yyz.us/git-howto.html
>>
>> This describes most of the commands I use in day-to-day kernel hacking. 
>>   Let me know if there are glaring errors or missing key commands.
> 
> Thanks for the work! I'd suggest also saying how to repack and cleanup.

Yes, I should mention repacking.  When you say cleanup, what 
specifically do you mean?


> Could also be a good idea to go through the steps for uploading to
> master.kernel.org or elsewhere?

Yes, push should be mentioned at the very least.

	Jeff
