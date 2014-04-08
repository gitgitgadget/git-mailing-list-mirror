From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: git log for only certain branches
Date: Tue, 8 Apr 2014 14:15:05 -0500
Message-ID: <CAHd499B2QWrdi=NNH5r6QMf7PcduuW9QW=0mLohgXTViAb-2Hw@mail.gmail.com>
References: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
	<vpqioqjlpf7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXbUL-0007Tk-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 21:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbaDHTPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 15:15:07 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:45278 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757561AbaDHTPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 15:15:06 -0400
Received: by mail-vc0-f179.google.com with SMTP id ij19so1168749vcb.38
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V+LBZZpX1t4eFDpaPJXfUyNOV4LImsCgwtOwXB29G3A=;
        b=z5YQiKh0WLY3/VFHS9r9AO/i4TfXFTR2cqfnJalGBBbIx4zgNDotEMo75PQrfDDxfW
         fxZeBIk+qTy22SSemy3lw1hbZyIv1E7N1lKZMSMxsubexgv2NfQik2opLTI1dGsjYKNH
         BMPwBDFry978bJl2Lc0yWMWQXw0uKT0OM0VnEG2ti2e79zBG3uuvbc+wMZ1VKtb1XB7k
         eJHmQUeFmq2aBerkazA7C9XRW/pJWtqE0gEUMhX9B52NSSionRPe6lJn4OvRuiFd4Kz4
         TWXQh0cAKoCV82+JeBU2+za7jebelHqRzF1pTiwuHI8HvXHGWVfGVGpht2+GLt2crLjB
         7Smw==
X-Received: by 10.58.123.71 with SMTP id ly7mr4686148veb.11.1396984505653;
 Tue, 08 Apr 2014 12:15:05 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Tue, 8 Apr 2014 12:15:05 -0700 (PDT)
In-Reply-To: <vpqioqjlpf7.fsf@anie.imag.fr>
X-Google-Sender-Auth: VF7OxWx__r48nqde0-qg6Dj2djs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245949>

On Tue, Apr 8, 2014 at 12:08 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> I have more details about my inquiry on StackOverflow:
>> http://stackoverflow.com/questions/22823768/view-git-log-with-merges-for-only-certain-branches
>>
>> Basically I'd like to know if it is possible to show the graph for
>> ONLY branches that I list.
>
> Not sure it'll directly answer your question, but did you read the
> "History Simplification" part of "git log --help"?

yes I did happen to read it but it makes my head spin. There's just
too much information there for me. I don't really know what
combination of options would give me what I want. However, it does
seem like the answer is in there somewhere.
