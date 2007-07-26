From: Bert Douglas <bertd@tplogic.com>
Subject: Re: problem after cvsimport
Date: Thu, 26 Jul 2007 02:18:08 -0500
Message-ID: <46A84AB0.8000703@tplogic.com>
References: <46A7FD99.9000305@tplogic.com>	<7vlkd3c16z.fsf@assigned-by-dhcp.cox.net>	<46A8459C.7030202@tplogic.com> <7vsl7b8x5w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:28:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxm1-0000am-On
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbXGZH2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbXGZH2e
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:28:34 -0400
Received: from fmailhost04.isp.att.net ([204.127.217.104]:39717 "EHLO
	fmailhost04.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbXGZH2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:28:34 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2007 03:28:34 EDT
Received: from [192.168.1.96] (adsl-220-183-197.mob.bellsouth.net[68.220.183.197])
          by bellsouth.net (frfwmhc04) with ESMTP
          id <20070726071830H0400pqfm1e>; Thu, 26 Jul 2007 07:18:30 +0000
X-Originating-IP: [68.220.183.197]
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <7vsl7b8x5w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53800>

Junio C Hamano wrote:
> Bert Douglas <bertd@tplogic.com> writes:
>
>   
>> Am I going to have to do "-f" a lot?
>> How will I know when to do it?
>> Why not do it all the time?
>>     
>
> With recent enough git, you shouldn't even have to do that extra
> "git checkout".  It was noticed and fixed quite a while ago.
>
>   
Thanks much.

$ git --version
git version 1.5.2.4

But I guess my basic question remains in two parts.
(1) Will it 'get out of sync' again sometime ?
(2) Will anything bad happen if I always do 'checkout -f' ?
