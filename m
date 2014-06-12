From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] l10n: de.po: fix typo
Date: Thu, 12 Jun 2014 19:59:14 +0200
Message-ID: <5399EA72.7060609@gmail.com>
References: <1402589551-3754-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:59:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9Hq-0004CS-MB
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbaFLR7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:59:19 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:62487 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaFLR7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:59:18 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so1670097wgh.16
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Of+hMDiA4wqPFrsaeboJ7z6ssVKTUcq3/nlfXk9VvGI=;
        b=sywslPVMtEvh0hruQs0rawF/FkTyMLgufzF8hMmlqxYSKqN6c7waWMALzmCtXntq1i
         ja3UOmoxiWTH03aXKr0lIgYjRFnuHXZlFkyTZdF6xx9HpOs/5eO74UUl3/ksMCzXqQIb
         7MBYkvZixivf1q6bWwy3/9rfzM3DV7rcWyS1qe/RurQI8Khms81+V2hyUsLNW6NVX4jA
         gTgZ4RVTIbFRcoE3QO06fBHpaZ3kqMx6orffFyECfTT46slB/cHH2scz7gsfoWV2CQ/P
         r10KIEmvN0+vjx9sCpNDXeRidDjIPkim8M5tBp2CIfisjxXCYml06Ha7q0fHrjbJbcP9
         9EnQ==
X-Received: by 10.194.10.130 with SMTP id i2mr18183056wjb.70.1402595957076;
        Thu, 12 Jun 2014 10:59:17 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id r44sm6140182eeo.18.2014.06.12.10.59.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 10:59:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1402589551-3754-1-git-send-email-ralf.thielow@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251466>

On 12.06.2014 18:12, Ralf Thielow wrote:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/po/de.po b/po/de.po
> index b777ef4..d7bc424 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -3503,7 +3503,7 @@ msgstr "Gewechselt zu umgesetzten Branch '%s'\n"
>  #: builtin/checkout.c:648 builtin/checkout.c:1033
>  #, c-format
>  msgid "Switched to a new branch '%s'\n"
> -msgstr "Gewechselt zu einem neuem Branch '%s'\n"
> +msgstr "Gewechselt zu einem neuen Branch '%s'\n"

How about ?
+msgstr "Zu neuem Branch '%s' gewechselt\n"


>  
>  #: builtin/checkout.c:650
>  #, c-format
> 
