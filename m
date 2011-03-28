From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2011
Date: Mon, 28 Mar 2011 10:17:37 +0200
Message-ID: <AANLkTin9REqDJhWbQ2JbESufcg6hSf6cw3NpiamXvkU_@mail.gmail.com>
References: <AANLkTikQ6=CrWuMemwv38HnBKPnt8CjQWqYj7oA8zVZ4@mail.gmail.com>
	<AANLkTikC5cagS8qYPDmWO+jhC4pHMkJq6zQN3QemMhwG@mail.gmail.com>
	<AANLkTikM7C_h5cwgd5KoddBUH3xsdwtBiGwM_2ecKR2k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Karol Samborski <edv.karol@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 10:17:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q47dv-0001M1-U4
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 10:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1C1IRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 04:17:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60255 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab1C1IRi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 04:17:38 -0400
Received: by wya21 with SMTP id 21so2612751wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EbDXR2ecb0jLrvvbZ/3BaGvMfEReEhsL+8mK/JRZ2qA=;
        b=Nph5inghKI0Uqtv+eWHURXpSX91SovQu9/jVL/VLqPsjF/sEI12vVzLSnTHl7o5vgl
         xFK1sHpgdV2Ev6nDnZ88kpE0WGVbWEMHWS/965005JqVCsHP9X+H8GhIakPGbagGcJZZ
         0FGF7Y4Bwv9bg2gAmAMXvKeaxrSHVlj4OAiE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CNdxTr2OXG748+72SJQ9IYNz8fHQ1qDKPNjylvNjQ2zfxNrwA8iol7cwcN1QP45sA/
         pe/u4EQbMXPUZZsGigHc6tynvkx+hjpYpefscVpeO3m2Q26QXL7Mbr375Sm/DUn9hCFj
         cheJy6BsAtlyGgpL4w9fG1NsXf46I4hkVgtms=
Received: by 10.216.246.12 with SMTP id p12mr3265425wer.91.1301300257195; Mon,
 28 Mar 2011 01:17:37 -0700 (PDT)
Received: by 10.216.89.12 with HTTP; Mon, 28 Mar 2011 01:17:37 -0700 (PDT)
In-Reply-To: <AANLkTikM7C_h5cwgd5KoddBUH3xsdwtBiGwM_2ecKR2k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170110>

On Mon, Mar 28, 2011 at 9:55 AM, Karol Samborski <edv.karol@gmail.com> wrote:
> 2011/3/28 Christian Couder <christian.couder@gmail.com>:
>>
>> It depends a lot what part of git you would like to work on.
>> Do you find one of the proposed subject interesting?
>> If yes, tell us and the relevant people will probably tell you what
>> you could start with.
>
> I thought about "Build in more external commands".

Ok, but which of the suggested commands would you like to rewrite?

When you know the one you want to work on, you can find the relevant
people and then put them in CC.
And you can look at its source code and find some parts that can
already be implemented in other existing commands in C.

>> I hope you will have more time during the summer otherwise it might
>> not be enough for the GSOC.
>>
>
> OK, maybe it might not be enough but I just want to do something for
> the others ;)
> It's ok if you will not approve my work later because of to slowly
> work but I will finish my task.

Great! We love people who finish the tasks ;-)

Thanks,
Christian.
