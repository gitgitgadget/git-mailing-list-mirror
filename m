From: Christian Biesinger <cbiesinger@web.de>
Subject: Re: [PATCH] Don't send copies to the From: address
Date: Sat, 11 Feb 2006 13:33:50 +0100
Message-ID: <43EDD9AE.70405@web.de>
References: <11396260373307-git-send-email-cbiesinger@web.de> <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net> <20060211045256.GA23066@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 13:34:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7twy-0006fl-4z
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 13:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWBKMeA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 07:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWBKMeA
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 07:34:00 -0500
Received: from smtp06.web.de ([217.72.192.224]:14031 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S1751417AbWBKMd7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 07:33:59 -0500
Received: from [85.124.17.142] (helo=[192.168.1.4])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.105 #340)
	id 1F7twm-0005Tl-00; Sat, 11 Feb 2006 13:33:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060209 SeaMonkey/1.5a
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060211045256.GA23066@kroah.com>
X-Sender: cbiesinger@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15940>

Greg KH wrote:
>> Me, personally I do not like CC: to people on the signed-off-by
>> list, but dropping a note to From: person makes perfect sense to
>> me, if it is to notify the progress of the patch.
> 
> Yes, they specifically should be notified of the progress of their
> patch.  And I like the fact that everyone else on the signed-off-by
> chain also get's cc: too.  It keeps everyone in the loop so they know
> what is going on.

I didn't break that! At least, I don't think I did, and I didn't intend to.

> Heh, getting a patch sent back to yourself this way is not a real big
> deal at all :)

Maybe... but if I send the patch to a mailing list (like this one), this 
means I get it twice. I guess that's already true for replies to the 
patch, so maybe I should just live with it...
