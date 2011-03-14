From: "Franz Liedke" <franz@develophp.org>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 17:14:43 +0100
Organization: develoPHP
Message-ID: <op.vsccqtbobl4hj1@metalltrottel.fritz.box>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box>
 <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com>
 <op.vsb95dilbl4hj1@metalltrottel.fritz.box>
 <AANLkTimW+01wriSjvEVEyQ8SE5RPxhGv_o2Rus9kw6ZQ@mail.gmail.com>
 <op.vscae5mbbl4hj1@metalltrottel.fritz.box>
 <4D7E38C6.4010804@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Sverre Rabbelier" <srabbelier@gmail.com>, git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 17:16:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzARJ-00047i-7s
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 17:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab1CNQPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 12:15:52 -0400
Received: from relay01.alfahosting-server.de ([80.86.191.88]:40135 "EHLO
	relay01.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756148Ab1CNQPw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 12:15:52 -0400
Received: by relay01.alfahosting-server.de (Postfix, from userid 1001)
	id DFE2932C03D7; Mon, 14 Mar 2011 17:15:49 +0100 (CET)
X-Spam-DCC: : relay01 1356; Body=1 Fuz1=1 Fuz2=1
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=7.0 tests=BAYES_50 autolearn=disabled
	version=3.2.5
Received: from alfa3007.alfahosting-server.de (alfa3007.alfahosting-server.de [82.197.146.14])
	by relay01.alfahosting-server.de (Postfix) with ESMTP id 1B90F32C0555;
	Mon, 14 Mar 2011 17:13:02 +0100 (CET)
Received: from metalltrottel.fritz.box (sd-89-66.stud.uni-potsdam.de [141.89.89.66])
	by alfa3007.alfahosting-server.de (Postfix) with ESMTPSA id C77852F04CD6;
	Mon, 14 Mar 2011 17:13:01 +0100 (CET)
In-Reply-To: <4D7E38C6.4010804@drmicha.warpmail.net>
User-Agent: Opera Mail/11.01 (Win32)
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with ClamAV 0.97/12834/Mon Mar 14 14:25:12 2011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168996>

Hey Michael,

in fact, I have been making commits both from the command line and from  
SmartGit from time to time, and yes, they were both running.
This has never been the problem before.

I ran some sort of cleanup tool yesterday, possibly about the time when  
the problem started (I only noticed it today). Something along the lines  
of 'git gc' maybe, if I remember correctly. Could that be the cause?

Thanks a bunch
Franz

On Mon, 14 Mar 2011 16:48:22 +0100, Michael J Gruber  
<git@drmicha.warpmail.net> wrote:

> Franz Liedke venit, vidit, dixit 14.03.2011 16:24:
>> Oops, sorry I didn't make that clear. The branch pointer is still
>> displayed next to the old commit in SmartGit, the GUI I normally use.
>>
>> On Mon, 14 Mar 2011 16:19:39 +0100, Sverre Rabbelier
>> <srabbelier@gmail.com> wrote:
>>
>>> Heya,
>>>
>>> On Mon, Mar 14, 2011 at 16:18, Franz Liedke <franz@develophp.org>  
>>> wrote:
>>>> "git status" and "git branch" both tell me I'm on my feature branch.
>>>
>>> And that one _is_ updating?
>>>
>>>> .git/packed-refs and .git/info/refs are both not updated.
>>>
>>> That's fine, don't worry about those.
>>>
>
> So, taking a step back - when you "make a commit", do you mean using git
> or using smartgit? Have you been mixing git command line and smartgit
> actions (while smartgit was running)?
>
> Michael
>


-- 
Using Opera's revolutionary email client: http://www.opera.com/mail/
