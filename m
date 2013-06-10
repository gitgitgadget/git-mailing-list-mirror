From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v5 00/36] Massive improvents to rebase and cherry-pick
Date: Mon, 10 Jun 2013 18:55:45 -0400
Message-ID: <CABURp0p7axsFHRLpXBCAZaMpeE1Ae5N1wNugEe3vsHCtX6_7EQ@mail.gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com> <CAMP44s2nbo97qFenwm3RaHYQ4K14knZpSvpLPPM3uPiFSRinuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 00:56:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmB0W-0000Tn-HH
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 00:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab3FJW4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 18:56:08 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:53300 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3FJW4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 18:56:07 -0400
Received: by mail-vc0-f180.google.com with SMTP id gf11so2803719vcb.25
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LoZjctQxH75jaMdyTpNXKuVZS1TZ2hcfeznq60ZBYyg=;
        b=xfMJc5TYbDqPVYrCm1mXkgAzs6fe0LGVYoB9sgFYProgha1V9M+WmbgFOzUcGFi22n
         P8VKSrkwvkwyxlwlfjLBC1EaacvP6ASvyEInBhat0nnfa6viT2BF84B51GVxKQnAFArO
         /VuUvoS8RCwQqtxpxTAUPbSuhKqP0qNRFFSvqFGF8ru6MtaZhIHrK2snxoGq2DC0/Gu2
         U0Ss2WvKzujYflpVO+VanU37MsmoIDz6lQElrBgmCBUongos/dZZrfbN/Ru21AaVE/AW
         vqU6cEU2D/GI4iGoBpOxzhIYeU3KwcVK9AakDzbi41MxcvABKuJoIvHY8fUahlWtY439
         wvtw==
X-Received: by 10.52.29.142 with SMTP id k14mr5862304vdh.124.1370904966754;
 Mon, 10 Jun 2013 15:56:06 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Mon, 10 Jun 2013 15:55:45 -0700 (PDT)
In-Reply-To: <CAMP44s2nbo97qFenwm3RaHYQ4K14knZpSvpLPPM3uPiFSRinuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227397>

On Sun, Jun 9, 2013 at 3:37 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Sun, Jun 9, 2013 at 2:24 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Same as before, but:
>
> Also, remove the patches from Martin von Zweigbergk, because
> apparently some people have trouble understanding that they were not
> part of this series.


Please try not to sound disgruntled. This attitude is toxic. You have
turned this change into a complaint: that "some people have trouble
understanding" which shows a genuine lack of understanding and
compassion on your part.  Instead you can phrase your change notes
more helpfully if you make changes only when you yourself actually
believe the change should be made.  If you cannot do this, perhaps you
can pretend.

  Also, remove the patches from Martin von Zweigbergk, which
  are not a part of this series.

Or even this:

  Also, remove the patches from Martin von Zweigbergk to avoid
  confusing reviewers.

Thanks,
Phil
