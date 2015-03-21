From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2015, #07; Fri, 20)
Date: Fri, 20 Mar 2015 17:47:00 -0700
Message-ID: <06716CEA-8980-4156-A67F-84B89872DCDD@gmail.com>
References: <xmqqr3sjcopt.fsf@gitster.dls.corp.google.com> <423416FC-1048-4D3A-B997-F1F796627242@gmail.com> <CAGZ79kapUtq0DbcD65v_aKmCXHz3hjSkEh1MJH1nWr2DhSa5hw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 01:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7ZH-0002qD-Kc
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbbCUArE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:47:04 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36545 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbCUArE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:47:04 -0400
Received: by pdbcz9 with SMTP id cz9so123383483pdb.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=INqyynPKRHpwnzTMIRE7Vf18Gm0RlPauvEk+hJSMiGU=;
        b=F4TSxAw7fpWTgTQc4uupI4eIsrC5Smj76S/TvB5UoniQHN+DOu6aiYKKMdELKqE7uU
         3H/5FnBY7VVTWFKlN7PhRfGZNNIxNB0nW8XwGY/n+pMHVsMpoPtSZXis4ixgC3kit4Xx
         unILSmqib3GkzmAsTg6YuG722XVMvyITYtxx3HfXuXZwOMYnuXl7qsu7XVUljeL7D9A5
         VOr0PMeba/nKpDS55bQOapzvxBRJWiBT/i/rZNFTnhXolkXnLqCPsPiYturuet+guaam
         8XtR4L3KcZbpqZNUkHEtybQ43mU414L2CBW1q0c7eWK3gZjgLlQJ+y1PoJFQzWhfRwoa
         sBoA==
X-Received: by 10.66.218.129 with SMTP id pg1mr192831314pac.65.1426898823563;
        Fri, 20 Mar 2015 17:47:03 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id pa6sm9891332pac.45.2015.03.20.17.47.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:47:02 -0700 (PDT)
In-Reply-To: <CAGZ79kapUtq0DbcD65v_aKmCXHz3hjSkEh1MJH1nWr2DhSa5hw@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265997>


On Mar 20, 2015, at 16:29, Stefan Beller wrote:

> On Fri, Mar 20, 2015 at 4:24 PM, Kyle J. McKay <mackyle@gmail.com>  
> wrote:
>
>> On Mar 20, 2015, at 15:02, Junio C Hamano wrote:
>>
>>> * bc/object-id (2015-03-13) 10 commits
>> [snip]
>>> Will cook in 'next'.
>>
>> Has this been merged to 'next'?
>
> Usually Junio writes the mail first and then does a git push <all  
> the branches>
> just before being done for the day. At least that's my suspicion as an
> observer of
> the timing when git fetch returns new shiny stuff and when these
> emails are sent.


I would expect that if it said, "Will merge to 'next'."

However the "What's cooking in git.git (Mar 2015, #06; Tue, 17)" also  
says "Will cook in 'next'" for this topic so I think that perhaps it's  
fallen through the cracks somehow.

-Kyle
