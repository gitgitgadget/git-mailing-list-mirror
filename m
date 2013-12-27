From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Dec 2013, #05; Thu, 26)
Date: Fri, 27 Dec 2013 16:54:52 -0500
Message-ID: <CAPig+cQXsdFocFeSR8YKh8crOwBFP0ZK0td2UbP-yypRYJhREQ@mail.gmail.com>
References: <xmqq1u0zcoci.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 22:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwfNQ-0005nW-Gp
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 22:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab3L0Vyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 16:54:54 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:43924 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784Ab3L0Vyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 16:54:54 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so4545100lam.11
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 13:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ak54dDhcDzMRjUNfyPl5j/bQRC00SbgslhA1xAVErk4=;
        b=vwZHE2ervk9ipreTueQmiGNz7ytIrUEKg8+AJ6CoGhDbl4c1Gq7moUh18IhTaxooq4
         Zh4FSKjBDlj7CX1nR2v8tvF7izeZSrSA9G5tmwb+8X2adgJP0117WBBOGCyrvlEyTxCo
         46DSpvmGKvJyBcv6BjVYhW4M84kfu7e/CLFCaoLLq5skzmfD2KYjMixC3jH9UrK6tKLo
         g/gkxSCzGIu8UC4BcnRADaNygyuTFB5LFa/+2mExVIgfevGWU30hMZ+xASz5BMP0ZJe4
         hR+mmKFNK6vXBF0SY7+v9qGWJQn5f2+XT6UU+g4vtfN4c7VFnaERH9wYcDlP1krxYIxg
         9QCg==
X-Received: by 10.152.120.231 with SMTP id lf7mr6894221lab.36.1388181292768;
 Fri, 27 Dec 2013 13:54:52 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Fri, 27 Dec 2013 13:54:52 -0800 (PST)
In-Reply-To: <xmqq1u0zcoci.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 0SfS8zZ-nEKEz3LA7kBfFzC038M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239749>

On Thu, Dec 26, 2013 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [New Topics]

Would $gmane/239575 [1] be of interest for "New Topics"?

[1]: http://article.gmane.org/gmane.comp.version-control.git/239575/
