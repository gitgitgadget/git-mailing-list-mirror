From: Karol Samborski <edv.karol@gmail.com>
Subject: Re: GSoC 2011
Date: Mon, 28 Mar 2011 10:44:51 +0200
Message-ID: <AANLkTik0t5QOjm6r=K8Lrm-oeksQ-A52vL7NO6wk9LYn@mail.gmail.com>
References: <AANLkTikQ6=CrWuMemwv38HnBKPnt8CjQWqYj7oA8zVZ4@mail.gmail.com>
	<AANLkTikC5cagS8qYPDmWO+jhC4pHMkJq6zQN3QemMhwG@mail.gmail.com>
	<AANLkTikM7C_h5cwgd5KoddBUH3xsdwtBiGwM_2ecKR2k@mail.gmail.com>
	<AANLkTin9REqDJhWbQ2JbESufcg6hSf6cw3NpiamXvkU_@mail.gmail.com>
	<AANLkTinPK1ONgL5Jv0AVnGngeZ3nUT5DX-dEV9LWWiGt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 10:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q484I-0002yU-F3
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 10:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab1C1Iox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 04:44:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57054 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1C1Iow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 04:44:52 -0400
Received: by bwz15 with SMTP id 15so2239351bwz.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=zuee4Rabdi1g5th5ty+QO+4pK2j8PLOw9Ss5Sn25ncM=;
        b=HRp6gHFRWmJyYvIPogMiqXS4Z+xKu+639QCFVEGydQbbQ2jS1USJaOVu9skcPnAJV+
         sQM7puE0TDc03WSC0E7lgopplBvyuoFGAkRpTmV8EFpbGnFSIywilaQeExjqfuWCDeQK
         DUfpy/StO423lEwazCobx4IGLwwjgf4q6mUHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=p7D6QlhZ/u5bS4n89Mx2eP/yUR2L8pixvWNQy7jVj8oCHV/diLgnTtw0NAyDi2pKko
         Efvz+T8g3umRPBHkkmJzeCc2Su6LHI9A3R4iEyUi6x8r/Hoi5cmyOwnDE9XucfH+Vepq
         MPxnCkzGZNM8vShjByn7Mg4E7Z+BQmMIHKnGc=
Received: by 10.204.16.198 with SMTP id p6mr3395211bka.143.1301301891510; Mon,
 28 Mar 2011 01:44:51 -0700 (PDT)
Received: by 10.204.240.17 with HTTP; Mon, 28 Mar 2011 01:44:51 -0700 (PDT)
In-Reply-To: <AANLkTinPK1ONgL5Jv0AVnGngeZ3nUT5DX-dEV9LWWiGt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170111>

2011/3/28 Christian Couder <christian.couder@gmail.com>:
> On Mon, Mar 28, 2011 at 9:55 AM, Karol Samborski <edv.karol@gmail.com> wrote:
>> 2011/3/28 Christian Couder <christian.couder@gmail.com>:
>>>
>>> It depends a lot what part of git you would like to work on.
>>> Do you find one of the proposed subject interesting?
>>> If yes, tell us and the relevant people will probably tell you what
>>> you could start with.
>>
>> I thought about "Build in more external commands".
>
> Ok, but which of the suggested commands would you like to rewrite?

I think I would start with git-pull.sh

> When you know the one you want to work on, you can find the relevant
> people and then put them in CC.
> And you can look at its source code and find some parts that can
> already be implemented in other existing commands in C.

OK, I will do this.

>>> I hope you will have more time during the summer otherwise it might
>>> not be enough for the GSOC.
>>>
>>
>> OK, maybe it might not be enough but I just want to do something for
>> the others ;)
>> It's ok if you will not approve my work later because of to slowly
>> work but I will finish my task.
>
> Great! We love people who finish the tasks ;-)

;)

Best regards,
Karol Samborski
