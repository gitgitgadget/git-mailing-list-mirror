From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Has Git 2.0 started to be integrated?
Date: Wed, 16 Oct 2013 15:16:52 -0700
Message-ID: <CAH5451n8NcnZVJu3-u6aAbBpXZf2Ezj-2ckQksF7wbnaWOwggw@mail.gmail.com>
References: <CAH5451=8BYN-Jsxsbw-3R36Kix__1kfW7r3_dtSbNhg+ukyNfg@mail.gmail.com>
 <20131016221139.GM9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 00:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWZPN-0001Sx-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 00:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761479Ab3JPWRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 18:17:33 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:58995 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760658Ab3JPWRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 18:17:33 -0400
Received: by mail-vc0-f171.google.com with SMTP id lf12so756763vcb.30
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/NjjiVdioWRZG4qNeQdCtXajDS00iADTtwHenBsEBik=;
        b=rO2XuO1008vBzy6U6U2VAEb7nb7CwRnAa7XkPj2SU+f4fhManJYk3082yxp69/nhs8
         mGdd/JTc3h2GR7ZSVnVDXoSKmKEce1qgsX/I4v5+05nYgUnGCRsv0rmnQEugvb0gnXoC
         tFvhIcqWrapQ8eRwlxqhJ5D3o6hfiDxGAqaM1pZsMkISmRV12qT+0u9QIp6mqhcfgVpE
         9y0BZVJeScIww1iDiQK8XjF2T/VR9ehkB9KlWthw+QYzPUVO3HY5UEON3CdTvVjiHRAS
         iDz1wWcMz9yHUrrVF8zvNlDwZUQyUzZcqGfGq/1Mh61cobygsZ10CbUqnKQY/Q+irNrm
         34GQ==
X-Received: by 10.58.155.10 with SMTP id vs10mr4239211veb.4.1381961852328;
 Wed, 16 Oct 2013 15:17:32 -0700 (PDT)
Received: by 10.220.58.197 with HTTP; Wed, 16 Oct 2013 15:16:52 -0700 (PDT)
In-Reply-To: <20131016221139.GM9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236278>

On 16 October 2013 15:11, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> There has been plenty of comments lately about how certain features
>> will be released in 2.0
>>
>> Have these features been tied together anywhere yet?
>
> They're in Junio's "jch" branch:
> https://github.com/gitster/git/commits/jch

Thanks! I'll build it and have a play tonight.

>> If not, when might such an integration branch be created? Would be
>> very interested in seeing how Git 2.0 plays, even in these early days.
>
> I wonder if it would make sense to keep these topics in "next" even
> though they will probably not be part of the next release, to
> encourage people who test that branch to try them out.  (Just thinking
> out loud.)

I guess that's my real question; we haven't had a major version
release for a long time and I don't know what the cycle will look
like. Will be interesting to see how it progresses.

Regards,

Andrew Ardill
