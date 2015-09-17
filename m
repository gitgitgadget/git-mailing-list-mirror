From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] l10n: de.po: better language for 2 strings
Date: Thu, 17 Sep 2015 11:15:08 -0700
Message-ID: <CAGZ79kYJkR-v=Ed+DJEo-fx4kJEc_hJjJadhTj+s8p46hpESCQ@mail.gmail.com>
References: <1442505032-11578-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, tr@thomasrast.ch,
	jk@jk.gs, Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 20:15:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdiH-0003Oq-Rb
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 20:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbbIQSPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 14:15:12 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34551 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbbIQSPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 14:15:09 -0400
Received: by ykdg206 with SMTP id g206so24943128ykd.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yPOpehDmz2eq6efo1n0fTv7jL2+ZyxuidcM06HCCsh4=;
        b=lO1WtvIGuV8yg+PblWwhBAyoP+DhGq69SfQ/d8CJv2zjTu++iaMngqhfUccfL7M9P0
         9xunLjaDU0cE/MYVCj6qdlDnqBUuWMX1o2gKmMXVo6gkv26CzJ3Xd+5mlJIQn/KY9qpg
         bqeNVUymXW7jzPp3C9NkF3NqIXEzPfu18nUxdIgoL+Hiy1181V8Nyn/Z7I+qfPC4I3n2
         bION10n7smkuMpMdulpkiEi7CJkGDRQmooOG0zyea7u8vD+td5C06IOyPO7DSut+Oghu
         nWzlQDO2iQJ0M9m/nyiBJhx4EnuM3cxQvVjUp3yZ1ppBstVvzuYLUwDs667OaRZNtbcR
         duKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yPOpehDmz2eq6efo1n0fTv7jL2+ZyxuidcM06HCCsh4=;
        b=HvN/7ORrFpvxtC7De8DnnIESNirBm9ovnGbGaSekc+Y0jEzp9aNze/9zTXN8wrq0Aj
         DkAAIhpWybtVHdHCWsahrLLQ/39jQM4fkz4aeQDcM1XdjTxoot1wCUceQrnyNZKdJKDH
         ujXvIKXO8D/RKIcZuUvVsOiEBZT0eour5QZozil+pIJ9feg8lSCWW9DoueZBTKe3t0fC
         VqpxzrHigGX3tjo+bEYlJcSP3T7qeFHpptAUfmuHwGK9Q09PKr0/iLNcwYmNO2JnBMSF
         4yxkfQMk30GlVRcGH3A7mfkagjWmAs6FnYZ6/gLSO9DdFGqJC8IFol/NyjEc5nxT6tKA
         L57A==
X-Gm-Message-State: ALoCoQkLi/tnAwaSSVvZGe5w9Vq88bOhPkreoemMPBTn9pgaY0n86LoFvbg0BgUDGdHaxbdGF8vb
X-Received: by 10.170.173.1 with SMTP id p1mr517901ykd.101.1442513708896; Thu,
 17 Sep 2015 11:15:08 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 11:15:08 -0700 (PDT)
In-Reply-To: <1442505032-11578-1-git-send-email-phillip.szelat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278157>

On Thu, Sep 17, 2015 at 8:50 AM, Phillip Sz <phillip.szelat@gmail.com> wrote:
> just 2 strings I think we could translate better.
>
> Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
> ---
>  po/de.po | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index 6ed3509..2f54093 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -10785,7 +10785,7 @@ msgid ""
>  "it will be removed. Please do not use it anymore."
>  msgstr ""
>  "Die -b/--binary Option hat seit Langem keinen Effekt und wird\n"
> -"entfernt. Bitte nicht mehr verwenden."
> +"entfernt. Bitte verwenden Sie diese nicht mehr."
>
>  #: git-am.sh:507
>  #, sh-format
> @@ -10795,7 +10795,7 @@ msgstr ""
>
>  #: git-am.sh:512
>  msgid "Please make up your mind. --skip or --abort?"
> -msgstr "Bitte werden Sie sich klar. --skip oder --abort?"

That was a hilarious translation.

> +msgstr "Bitte entscheiden Sie sich. --skip oder --abort?"

I wonder if we should use a better wording upstream
"Only one of --skip or --abort allowed".
I think that is what we do usually, e.g. in builtin/clone we have
    die(_("--bare and --separate-git-dir are incompatible."));

But this is definitely better than before. :)

>
>  #: git-am.sh:560
>  #, sh-format
> --
> 2.5.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
