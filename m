From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] de.po: Fixup one translation
Date: Tue, 23 Sep 2014 04:06:42 -0400
Message-ID: <CAPig+cTFW7gEEezkEbRTu-N88Er26OEm6FE47M8c1XSh8Q_a7g@mail.gmail.com>
References: <1411457847-10419-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ralf.thielow@googlemail.com, Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:06:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWL7Y-0002Ft-S0
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 10:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbaIWIGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 04:06:46 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:37431 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbaIWIGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 04:06:43 -0400
Received: by mail-yk0-f170.google.com with SMTP id 19so1660687ykq.29
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=a9o6aCY1d9O4y6S7O5fvqUKSfqTgqCg0JfCrPjfGrzI=;
        b=RK6CpWVpd+YalCEXNu9VgZ10w2pNliPK6A5Hm/ufCwIuR+qJ09SZFU4bePCLzc7Yqe
         vaQ8sd+bNoI6aEypoTvr+z65rWGz5gFSkxAOBCEGQ8jV8ul2jscAQSGoI80eFfPsPa5T
         PEQs9umIa7Y0cQWwf+W3vYlXtLGy1fkbUWpFyEauipdrT7duCmBk0XzlL762KWXvTFo5
         dxZ1t4Rv/1dyz8m7CCv8oTmdV9ugXHZ+Ivsi+CTDyhWZrdrbnQR0TEWVBmPKcpyC/hD9
         ycFGb6wCpddbrvlWbwSlOZKh7VjgwV2j+UUV2k+ULM6NDuhv87BpJDoWSi0/5y8hP7aw
         yc5A==
X-Received: by 10.236.42.75 with SMTP id i51mr33244835yhb.43.1411459603000;
 Tue, 23 Sep 2014 01:06:43 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Tue, 23 Sep 2014 01:06:42 -0700 (PDT)
In-Reply-To: <1411457847-10419-1-git-send-email-stefanbeller@gmail.com>
X-Google-Sender-Auth: ith4PyfDYr4jDMNgxz88WvVH6hY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257403>

On Tue, Sep 23, 2014 at 3:37 AM, Stefan Beller <stefanbeller@gmail.com> wrote:
> English grammar with German words doesn't make it a German translation. ;)
> We also need to fix the

Sentence fragment.

> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>  po/de.po | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index e5d2b25..bae3723 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -3463,13 +3463,13 @@ msgid_plural ""
>  "\n"
>  "%s\n"
>  msgstr[0] ""
> -"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
> -"einem Ihrer Branches:\n"
> +"Warnung: Sie sind um %d Commit hinterher, folgende Commits sind in\n"
> +"keinem Ihrer Branches enthalten: \n"
>  "\n"
>  "%s\n"
>  msgstr[1] ""
> -"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
> -"einem Ihrer Branches:\n"
> +"Warnung: Sie sind um %d Commits hinterher, folgende Commits sind in\n"
> +"keinem Ihrer Branches enthalten: \n"
>  "\n"
>  "%s\n"
>
> --
> 2.1.0.238.gce1d3a9
