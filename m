From: Andreas Ericsson <ae@op5.se>
Subject: Re: Possibility of a MinGW version?
Date: Sun, 25 Dec 2005 00:44:47 +0100
Message-ID: <43ADDD6F.7010502@op5.se>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se> <7vwthus7gr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 00:45:08 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqJ4O-0006iO-Dx
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 00:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVLXXo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 18:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVLXXo5
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 18:44:57 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:65486 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750758AbVLXXo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 18:44:56 -0500
Received: from [192.168.1.42] (217.210.107.34) by pne-smtpout1-sn2.hy.skanova.net (7.2.069.1)
        id 43AA7832000B9759; Sun, 25 Dec 2005 00:44:47 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwthus7gr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14040>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>The fact that there are 39 bash'ish shell-scripts does little to help a 
>>native port...
> 
> 
> Can you defend that "bash'ism" comment for all 39?  The one I
> know of and would want to get rid of its bashism by rewriting is
> git-grep, but most of them I thought was plain POSIX.
> 

Not really, no. I meant "there are 39 shell-scripts known to work with 
bash but not necessarily known to fail with any other shell", which 
usually means "it will break with some shell or other, although the 
shell that breaks is unusual enough for everyone not to have tested it 
yet". I'm probably being a bit super-anal and anti-MS biased.

I wrote the first mail being terribly hung over and this one being 
slightly tipsy. I now get the feeling that everything will work out for 
the best. Happy christmas everyone.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
