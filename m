From: Rajkumar S <rajkumars@asianetindia.com>
Subject: Re: [PATCH] cvsimport: Remove master-updating code
Date: Tue, 07 Mar 2006 19:12:01 +0530
Message-ID: <440D8DA9.4040206@asianetindia.com>
References: <44094618.6070404@asianetindia.com> <46a038f90603060124h4ea1c3c6gaa5d8b52ed311230@mail.gmail.com> <46a038f90603060137o758ea7ch6c40652ad86a102a@mail.gmail.com> <440C68B9.9030305@asianetindia.com> <7vek1e6cnk.fsf@assigned-by-dhcp.cox.net> <20060307090834.GX13888@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 14:42:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGcS1-0003kL-Jn
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 14:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWCGNmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 08:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWCGNmG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 08:42:06 -0500
Received: from vhs2.linuxense.com ([64.34.173.90]:63198 "EHLO
	vhs1.asianetindia.com") by vger.kernel.org with ESMTP
	id S1751022AbWCGNmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 08:42:05 -0500
Received: (qmail 14556 invoked by uid 1014); 7 Mar 2006 13:42:04 -0000
Received: from rajkumars@asianetindia.com by vhs2.linuxense.com by uid 1003 with qmail-scanner-1.22 
 (clamdscan: 0.74. spamassassin: 2.63.  Clear:RC:0(202.88.239.86):SA:0(0.0/6.5):. 
 Processed in 0.676879 secs); 07 Mar 2006 13:42:04 -0000
X-Spam-Status: No, hits=0.0 required=6.5
Received: from tarpit.linuxense.com (HELO [192.168.3.49]) (raj@linuxense.com@[202.88.239.86])
          (envelope-sender <rajkumars@asianetindia.com>)
          by vhs1.asianetindia.com (qmail-ldap-1.03) with SMTP
          for <smurf@smurf.noris.de>; 7 Mar 2006 13:42:03 -0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: smurf@smurf.noris.de
In-Reply-To: <20060307090834.GX13888@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17334>

smurf@smurf.noris.de wrote:
> Junio C Hamano:
> 
>>I do not understand what cvsimport is trying to do here; I
>>_suspect_ the part that updates the "master" branch head might
>>be a bug.
>>
> 
> This should fix it.

It's working fine for me. Thanks!

raj
