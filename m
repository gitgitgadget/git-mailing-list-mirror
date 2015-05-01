From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Improving Readability of the entire Codebase
Date: Fri, 1 May 2015 16:37:55 +0100
Message-ID: <CAKB+oNs2iaXSSoiu4-OMT7VgSYdigU0k+gT0NMqSBw1pRZhe0A@mail.gmail.com>
References: <CAKB+oNv1q=62a0-T7CCcOAOU+sfXPiyZPMB1qWxf-8zX=4PPpg@mail.gmail.com>
	<CAGZ79kbORH6S5Cq03tRU0eHdu75QF1phZFiDsyiFQ+sg_2V83g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 01 17:38:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoD0q-0002dB-Jh
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbbEAPh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 11:37:57 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35831 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbbEAPh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:37:56 -0400
Received: by qkhg7 with SMTP id g7so52630798qkh.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7/Pp/0fmDtwmJ5PnBZWbPfyt+jJ4mQNMfia8rmpBX2U=;
        b=JIIY6WPhXgBWvR/IIwjkvnEE3AUJr7wj6qfCN7zGUbZh6bHgcXZ5azmgWTc6ICveas
         M8Ehc7b4cJev+jkT7gyxg87HWca8tWtSOIGeLzFS3/6MAKgFPH+AfxbisIWmTT3k6nWB
         6srg20xgg4gSqcYapcWXLxVXjz3PsYTKhL/7Y6VHb54XHa3Jmu6gahRbcxeQ1lmo/zRm
         1MlXPzHCyCIeMSROT//JzXz+tpojsMgwQ6hXmUgTGzfKcARw6nTeIC8eFnemMrSTN872
         OHJ8uZ3BhReN3KJ1WuWputjex3pa7mX9Ahc2crkc7ZJLYdiMu8lghPegmjhZIeUKHsC2
         A0Hg==
X-Received: by 10.140.145.78 with SMTP id 75mr6541496qhr.61.1430494675702;
 Fri, 01 May 2015 08:37:55 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 08:37:55 -0700 (PDT)
In-Reply-To: <CAGZ79kbORH6S5Cq03tRU0eHdu75QF1phZFiDsyiFQ+sg_2V83g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268148>

Thanks so much, i am learning the community, so that is why i am
making a lot of mistakes. Thanks for the correction. I have started it
already and submitted a patch. Can you have a look and tell me
something?
Regards
Alangi Derick Ndimnain


On Fri, May 1, 2015 at 4:35 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, May 1, 2015 at 8:08 AM, Alangi Derick <alangiderick@gmail.com> wrote:
>> Hello,
>>     While reading the source codes of Git, i found something. Some
>> sentences and words are not in their correct cases. For example like
>> starting a sentence with a lower case whereas it should be in upper
>> case. I want to go through the entire code base and correct the cases
>> of these letters to improve on readability. I will also use this
>> opportunity to learn the source codes and familiarize myself with the
>> code base.
>
>> If its a nice idea, someone should please give me the go
>> ahead. I will be waiting.
>
> That's usually the wrong approach within the Git community as
> there are no people who give the go ahead.
> Just do it and once you have some results these
> can be discussed on the mailing list.
>
>>
>> Regards
>> Alangi Derick Ndimnain
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
