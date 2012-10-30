From: Mike Norman <mknorman@gmail.com>
Subject: Re: Links broken in ref docs.
Date: Tue, 30 Oct 2012 01:07:37 -0700
Message-ID: <CAJr+XPE17vbqKJuJ4DfjPVfhzvL7B24eJJU-ipqUi3R+7p_yig@mail.gmail.com>
References: <CAJr+XPGm4djBh+vacG5Ff=Y6aYmWbcUXOV9x2jekgnsGsk4b-g@mail.gmail.com>
	<CAH5451nFf_SY4K2DS52vhP6VeXSmeikUrc0zy8HK3xmGgs+UGg@mail.gmail.com>
	<CAJr+XPETQ2Jifns3_dfoB-sLLru2=Jkofb5RrBxLE4Fa9Aqp7A@mail.gmail.com>
	<CAP2yMaKzLHiqpUtfcNtSFo8aqnbvS9RvCzC-DZvQMBgXvte5jw@mail.gmail.com>
	<CAO54GHBvWoqZRbDwhQnmjGsBLKfGiv-JTpAakrAjiqEXYHHXPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Chacon <schacon@gmail.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT6re-0002qD-9Z
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 09:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab2J3IHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 04:07:41 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44820 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab2J3IHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 04:07:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5545857oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QFxuYRScuSq5gDbPhCfBEXhC03LkEiLZCf2K2yyj/l4=;
        b=hVT6H2HvA+V4ShSw9OfxlRQyKYTyZddbgzaHEUdTLEtGx9VEiPvZFarZ58hj2AX4ln
         Thbw1n7gyVkcx1MKymodaQqlQrk9Fkvj8+umtoHqoYrfCm0JXTCLSxzILZ3WUNIzN/uV
         HI6LTLDFPA3cKOG8Y9Tgqm0Z5cmX3DrV8zOjhQdbLjKVFPjI4M3Upq98gNK4HrZphejo
         MQF2SOE2rdOgUjAklW1t84vCmvZyLzESSPfUCVjjt0eiDK/u4hgOG2lREtJG/7h2zQmr
         k6MQMHxhY7kFhgUnQmtoE6bOB16QD9N0+L7XNH99viIT9nFWn/kaw8aqDtIYzJ0th0nQ
         Njlw==
Received: by 10.60.7.65 with SMTP id h1mr28973072oea.66.1351584457357; Tue, 30
 Oct 2012 01:07:37 -0700 (PDT)
Received: by 10.76.76.202 with HTTP; Tue, 30 Oct 2012 01:07:37 -0700 (PDT)
In-Reply-To: <CAO54GHBvWoqZRbDwhQnmjGsBLKfGiv-JTpAakrAjiqEXYHHXPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208685>

Not seen any recently. I'm guessing the dev is in the path of
hurricane Sandy? (Not sarcasm, btw.)

On Tue, Oct 30, 2012 at 1:04 AM, Kevin <ikke@ikke.info> wrote:
> Any follow-up on this?
>
> On Tue, Oct 23, 2012 at 7:11 AM, Scott Chacon <schacon@gmail.com> wrote:
>>
>> So, this is due to the major AWS outage today.  git-scm.com is hosted
>> on Heroku and thus on AWS.  Heroku is continuing to bring up their
>> database systems in the wake of the massive AWS outage.  Once that is
>> back online, git-scm.com will also be back online.
>>
>> As for the git-fetch issue, we'll look into it once Heroku is back online.
>>
>> Scott
