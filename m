From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/9] transport-helper: updates
Date: Thu, 29 Aug 2013 14:26:40 -0500
Message-ID: <CAMP44s2jG8aD66uhiB9a0HYGro1p7yHkMJ4+XmzQD+a6f42QhA@mail.gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqn42tgb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7rq-0001QK-FP
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139Ab3H2T0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:26:43 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:50890 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab3H2T0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:26:42 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so740772lab.6
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cE8ZiCj+8JeGm7ByQkjsi20Ls0JeW9ZyAZvhH3I96hQ=;
        b=zAwW8H0xDYUHPebZLWXyL4LMqaFTCJpSJCuXUnZ/Ho7EFOanC84NImCJ0iElrYA1HF
         TBpFJTzi/uhaMvZT2iSuyIpN8/I/WpB8kB5VvEwRLaCgdfSC2+f1jzMUVcNoph5LrWoP
         lBS3anCd1ix4umYCN25rgQXmUZUHEVeF4gYetgzncYZVGtXTLNpBaldJ3zCRjXjC87bG
         vKCedIrbEMyarn/kCrF+3nN1yLhU/WWulW68CPaON2WnALH2cKgIHVQigkykZvtxnb0A
         JCgpt05GmMRFvrJt6T5TwThD/8euWYkJEorrTdaPrM12nXOrooLZOq7jV5MkYsq51J7F
         phYA==
X-Received: by 10.112.72.130 with SMTP id d2mr2780594lbv.40.1377804400937;
 Thu, 29 Aug 2013 12:26:40 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 29 Aug 2013 12:26:40 -0700 (PDT)
In-Reply-To: <xmqqwqn42tgb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233348>

On Thu, Aug 29, 2013 at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Some of these were were sent before and rejected without a
>> reason,...
>
> Earlier, you were asked to leave because many constructive criticism
> or suggestion for improvement to your patches in reviews led to
> stubborn resistance, ended up wasting everybody's time and left a
> bad atmosphere on the list.
>
> It seems that Matthew is trying to see if you can work better with
> others than before after a break, but I personally am not hopeful
> yet and do not want to waste my/our time on flamewars like we saw in
> the past.
>
> So I'll look at these and may pick patches that are obviously and
> trivially good, but will refrain from asking clarifications and
> suggesting improvements, etc. on other patches that I suspect will
> end up wasting the time of people again.  Do not take silence from
> me as a silent agreement.

If you do not pick these patches, the only one that looses is the Git
project and its users.

-- 
Felipe Contreras
