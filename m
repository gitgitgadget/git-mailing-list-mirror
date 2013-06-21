From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 19:32:45 +0200
Message-ID: <CALWbr2xzozGkH23pYCj6XvW3nXF47YCEFGhy+-ivQRrW9FVOPg@mail.gmail.com>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
	<CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
	<7vk3lno40x.fsf@alter.siamese.dyndns.org>
	<CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
	<7vtxkrmlz5.fsf@alter.siamese.dyndns.org>
	<CALkWK0mUcJ1f0xP2w-fUFr-tMSKMX23_nmYQUYXw3zjw7Hm9GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 19:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq5Cd-0003Pg-0c
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 19:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423490Ab3FURcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 13:32:47 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:42782 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423122Ab3FURcq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 13:32:46 -0400
Received: by mail-qc0-f170.google.com with SMTP id s1so4898003qcw.29
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9fNk9bcJTA/kG5wjqrZC4QrrBXvTgnA4hH6gupZazxs=;
        b=K2/Ov1GDJjQz2a8EAT2QCgzr+9v/m2GRZVZ3UoOHBcIFDZ20DCmvmwUxgH47wNhouR
         Rhod2+RFGsssIsZHc50bzgAKTZNf3QqhSPqQYZTFEUG53X0UltZ/aYUWSlQwSPAPWxzt
         FH7pJLgWwd7nwFCPoPdBhh/aINtnpFsJLc5hDssn/UKmzIPHDoV5AE+3DK4hdpUrumaZ
         wHvAAYw4IoqUw7aqHUoEtrR0qlMQZlBxkteZDHsNfJ1+YEiVMDkBxKxU5haYYMfyRKwC
         D4uEx2cmBh5uH4cwcgbLFT+hT2m6gSlpOYDKGBoqstgCILr2iYbZAzIPYb+LbYrEwmCN
         42IQ==
X-Received: by 10.224.182.79 with SMTP id cb15mr15211046qab.48.1371835965770;
 Fri, 21 Jun 2013 10:32:45 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Fri, 21 Jun 2013 10:32:45 -0700 (PDT)
In-Reply-To: <CALkWK0mUcJ1f0xP2w-fUFr-tMSKMX23_nmYQUYXw3zjw7Hm9GQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228637>

On Fri, Jun 21, 2013 at 7:13 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>>> ...  I've noticed a significant decline in
>>> list-reviews in general: a lot of good code on the list hasn't been
>>> reviewed.
>>
>> Hmph, I do not particularly see that happening.
>
> Observer bias.  To verify either claim, could you run some stats on
> the ML archives [1] and report the results?

Do we really need that ? Flaming generates lots of useless discussions
that would be difficult to interpret/extract from your numbers.
I think we should focus on improving what is left to improve. That is
of course merely my humble opinion.
