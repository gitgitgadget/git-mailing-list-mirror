From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 09:58:22 -0400
Message-ID: <433D447E.9030103@pobox.com>
References: <433BC9E9.6050907@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net> <433D1E5D.20303@pobox.com> <200509301402.46740.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 16:01:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELLPL-0000wy-TX
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 15:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVI3N6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 09:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbVI3N6e
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 09:58:34 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46212 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030300AbVI3N6d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 09:58:33 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1ELLPB-0003Ij-8l; Fri, 30 Sep 2005 13:58:30 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <200509301402.46740.oliver@neukum.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9561>

Oliver Neukum wrote:
> Am Freitag, 30. September 2005 13:15 schrieb Jeff Garzik:
> 
>>Thanks for all the comments.  I just updated the KHGtG with the feedback 
>>I received.  Go to
>>
>>	http://linux.yyz.us/git-howto.html
>>
>>and click reload.  Continued criticism^H^H^Hcomments welcome!
>>
> 
> 
> The error is still there.
> 
> oliver@oenone:~/linux-2.6> git checkout -f master
> usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])

Something's wrong with your installation, not the instructions.  Works 
fine here.

	Jeff
