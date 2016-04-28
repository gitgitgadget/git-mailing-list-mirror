From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] Fixed grammar mistake in the french localization
Date: Thu, 28 Apr 2016 19:00:15 +0200
Message-ID: <87bn4tzn1c.fsf@gmail.com>
References: <01020153f9be55b1-84948015-9e20-43da-9f9b-d2658d744c64-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
To: Antonin <antonin@delpeuch.eu>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpIf-0002b2-4O
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbcD1RAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 13:00:22 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36447 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbcD1RAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 13:00:19 -0400
Received: by mail-wm0-f42.google.com with SMTP id n129so73080860wmn.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iOUN0oAb1IGR5ePLbhhLPAD8W/Cwz2IZcrNP8QJR6XM=;
        b=JKoRW0mXI4ZGkD8eBfJCM8b+zBk/OvOfyFSeACyuMKEgnU43ZaV19uKsZaUbY6iKmx
         o/RuiVq9nHR6Qoi8+cXhvY4bm+DXAWav50362ZteumXDQg8xGlce2jl9+07jUKRSjx3f
         fFwCdknBL8RkbdaPGtUDka6OmsIQDR6mf1RdyU2S2ygVBGK2MYo7maZ+u5o+/gjcxZxu
         wICETiKTJt39WVwHePLX3XaMX7sAmfJKoEv8uTrrljMXm/bK6Qu9kQiPpq3Y9zwg7hH0
         L43Yx4ZnmHPfEI4qY0XljHjJVrDNQWehaWlbpVFcu67ZMqR3E67CyzBDhU09u9yfTyJo
         Y5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=iOUN0oAb1IGR5ePLbhhLPAD8W/Cwz2IZcrNP8QJR6XM=;
        b=gsMx+uLwsBgB68Y0dBTpo3w4Ofp1byU9tpndnCk1Kz3rmDuBL6Z/+tir9+R/GtrAb9
         pBHfqEdXa2yFYEku+7gSkyZ6/1u04hmqdHeDejBI6wCXx6hEahwcc0R4wNgl5fN6M4f/
         fWqYiFkeWVuhpH8TAs56oq+da4Vl7Xt0jvgd4/7sOfjuNtNPFR0EUiESBYolLP0VZ0FT
         sK2QNH4srlTeM7AvaDoisscDQNf77OpksHZMESxUIk1R77h6AEuzC8pDymAsZ9SuzCwn
         QNXd2GMZRtsUXDwFcSiGluTKNNyrhpXJSica3Rtp1uvnsvKiwlUXeVJxZlGE2SFuWewm
         ka8w==
X-Gm-Message-State: AOPr4FUl2M2cAzS3MirurUfAS3yTli7E2pzE+jJ1+XmxYB5ruH30FJ4JeruMZId8jBEpjA==
X-Received: by 10.28.10.7 with SMTP id 7mr31410526wmk.43.1461862817636;
        Thu, 28 Apr 2016 10:00:17 -0700 (PDT)
Received: from ralf-ubuntu (cable-82-119-19-197.cust.telecolumbus.net. [82.119.19.197])
        by smtp.gmail.com with ESMTPSA id e12sm14992767wma.15.2016.04.28.10.00.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 10:00:16 -0700 (PDT)
In-Reply-To: <01020153f9be55b1-84948015-9e20-43da-9f9b-d2658d744c64-000000@eu-west-1.amazonses.com>
	(antonin@delpeuch.eu's message of "Sat, 9 Apr 2016 06:38:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292922>

CC'ed Jean-No=C3=ABl who maintains French translation.

Antonin <antonin@delpeuch.eu> writes:

> "tous le d=C3=A9p=C3=B4ts distants" -> "tous les d=C3=A9p=C3=B4ts dis=
tants"
> ---
>  po/fr.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/fr.po b/po/fr.po
> index 88b0b8a7..36c7c99 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -6135,7 +6135,7 @@ msgstr "git fetch --all [<options>]"
> =20
>  #: builtin/fetch.c:92 builtin/pull.c:166
>  msgid "fetch from all remotes"
> -msgstr "r=C3=A9cup=C3=A9rer depuis tous le d=C3=A9p=C3=B4ts distants=
"
> +msgstr "r=C3=A9cup=C3=A9rer depuis tous les d=C3=A9p=C3=B4ts distant=
s"
> =20
>  #: builtin/fetch.c:94 builtin/pull.c:169
>  msgid "append to .git/FETCH_HEAD instead of overwriting"
>
> --
> https://github.com/git/git/pull/221
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
