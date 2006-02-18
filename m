From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/5] Support ancient systems
Date: Sat, 18 Feb 2006 03:35:17 +0100
Message-ID: <43F687E5.8070905@op5.se>
References: <Pine.LNX.4.63.0602171517580.24274@wbgn013.biozentrum.uni-wuerzburg.de> <94fc236b0602170718t76e01204ib2b50e33eaa5eeaa@mail.gmail.com> <20060217170345.GB3468@ELSAMSW37164> <Pine.LNX.4.63.0602180109480.525@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 03:35:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAHwU-0000pA-JV
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 03:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWBRCfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 21:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWBRCfX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 21:35:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54189 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750742AbWBRCfW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 21:35:22 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8E3ED6BD04; Sat, 18 Feb 2006 03:35:21 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602180109480.525@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16383>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 17 Feb 2006, Tim O'Callaghan wrote:
> 
> 
>>On Fri, Feb 17, 2006 at 04:18:35PM +0100, Adrien Beau wrote:
>>
>>>On 2/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>
>>>>I just got git to work on an Irix box. These are the changes I needed
>>>>to apply. Maybe some of them are of use for other ancient systems... You
>>>>know, I like ancient systems. And if I could get my hands on a VMS, I
>>>>would try to get git to work on it, too ;-)
>>>
>>>You can get free VMS accounts at the Deathrow Cluster:
>>>http://deathrow.vistech.net/
>>>
>>>If you're serious about using your account, you'll find that the admin
>>>team is pretty supportive and friendly.
>>
>>You should check out polarhome.com if you want a variety of platforms
>>to muck about on, including IRIX, Plan 9, OpenVMS Vax, OpenVMS Alpha
>>etc.
>>
>>I work on VMS systems at the moment and i thought of attempting to
>>port git for the hell of it. I decided not to bother for a variety of
>>reasons, but mostly because it looked like too much work :)  
> 
> 
> Well, I did not remember that VMS does not have a proper fork() call.

It doesn't. It's got vfork() though.


> BTW, my remark about VMS was more tongue-in-cheek than not...
> 

Thanks anyway. I would never have gotten that link to polarhome if you'd 
kept your tongue straight.


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
