From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: l10n: Update Catalan translation
Date: Wed, 07 Oct 2015 15:57:19 -0700
Message-ID: <xmqqio6is2wg.fsf@gitster.mtv.corp.google.com>
References: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com>
	<xmqqk2r0wo8g.fsf@gitster.mtv.corp.google.com>
	<CAMMLpeSMLjzq-8kkSx-shJGqVS1ZHsC=nKG5pOSyyz7ymnE95w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 00:57:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjxeO-0008TO-PL
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 00:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbbJGW51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 18:57:27 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33860 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbJGW50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 18:57:26 -0400
Received: by padhy16 with SMTP id hy16so33966978pad.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jPbRjgq3C9yWgbxQ9PMD0hkkDu/mKj3cHltqK8QGQxs=;
        b=VMkBEKw654H++XqF2NpKmFKgYBUUk0NWjS4qFfFEVYb6V0x9HB/kCFR1aRAWaU9ekb
         6X1Zqb4G2rQyv4+FFyc5VDT21LznYZrGnPfUDUT1GyHEPug1VJ1nk71J8SqlCXGCnFNW
         JGHVNkhVWE961/+yqu93lA6OeW5yDbu2vTWSp8xVGQ2Qv8UlJKWe1fmxcitWmjsSoE7u
         uDIc3N4jssYOw5pVYQDbnscyN1tBCLpUj2FPykvXVf6i9Oi7G7CGxZXwQ9b0bsnGkItF
         rkG+V5X9ehHKB4+fo5ICIxbsZYKRqadHiyVnb0pSsKgDMj5h83TG3GKNExju2OtX8InH
         EmsA==
X-Received: by 10.66.142.202 with SMTP id ry10mr4102862pab.86.1444258641293;
        Wed, 07 Oct 2015 15:57:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id dy8sm28021072pab.38.2015.10.07.15.57.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 15:57:20 -0700 (PDT)
In-Reply-To: <CAMMLpeSMLjzq-8kkSx-shJGqVS1ZHsC=nKG5pOSyyz7ymnE95w@mail.gmail.com>
	(Alex Henrie's message of "Tue, 6 Oct 2015 09:42:05 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279209>

Alex Henrie <alexhenrie24@gmail.com> writes:

> 2015-10-05 23:38 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>>> The gitk included in git 2.6.0 crashes if run from a Catalan locale.
>>> I'm hoping that a translation update will fix this.
>>
>> I seriously hope that l10n files would not "crash" applications.
>>
>> I wonder if you are hitting $gmane/278863 perhaps?
>
> I really don't know. Gmane bug 278863,...

Sorry, what I meant was this:
    
    http://article.gmane.org/gmane.comp.version-control.git/278863

which seems to have come from $gmane/278846 and $gmane/278820.
