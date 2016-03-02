From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] l10n: de.po: fix typo
Date: Wed, 2 Mar 2016 18:10:00 +0100
Message-ID: <CAN0XMOKLbWRkujWFFNoDnCT1gAfz90rEFoRUo6=FCNOKkCPBzg@mail.gmail.com>
References: <1456919186-5538-1-git-send-email-christophhoopmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Christoph Hoopmann <christophhoopmann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 18:10:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abAHp-0001BZ-He
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbcCBRKD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 12:10:03 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36829 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcCBRKC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 12:10:02 -0500
Received: by mail-lb0-f196.google.com with SMTP id gn5so9187808lbc.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=4YMrS3QK1uC6NOAZycmW8L9z3bG1lLjk9f3dYNB4sAI=;
        b=OSuZwDAIUbRMv6m8d5u9rxm22/bIJX+HyPhvHITzuQELtAevvZNwr7da1K4h7gXTx6
         HVFOqFw3dFyNLfcmJx0kMQV9kin/X4OBVy3TkfeCnolDGN6aeJOS1hhe09btKkJfMnwR
         ceu6E8FASaPZov9UbGSJtYD1MX8Y5zPfHDoWaoOLQIn6FVTUAlqqewdQW3BT4QfP8ozA
         a4grnIfAlaPZ1x5PqV2w7vLxI/ql3D7wwUf8RgittTt7FFPCFjIngRO6fwYF9x3xgh/1
         HaVHjs+WUUdNOO2FqgsYzYu/8IZCgH0MrpHhmtLziCMrO2BLLwjP6RmKWt8e1cgW9x1H
         AOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=4YMrS3QK1uC6NOAZycmW8L9z3bG1lLjk9f3dYNB4sAI=;
        b=jXeh1hKXfERNAY19o//I57l3fsmRjdU7NsL1qC3BaxE4jGuGtCXU7MHVChvObaEGtx
         btk3d5IF0acXzj8qEUn1DNBDN9CY6wwudWlR4nZWRPkWBM31x1CdZv+uWACZN9cgzzZq
         FHpnNYKQ9LKpWjfitCqLh70/Z2yjBAcisYu3R1t55DgTmfPsaJ3KNCjUBYV5JF+SP6Cf
         jdXbxGMHeIPWVX/1ME3Y65g0mgx5jDeGpixtX5XTH+XRNEyS5t3wJ3E+GYklfOXQ5X11
         2ri7MWQcbmYzrEsH1VOQGX3CcMkdTMD7aj1qe/lrVPe2xKlr+5xSeVWWM5rOft5kj94i
         JTJw==
X-Gm-Message-State: AD7BkJLOcNrjM9bgw0nSUxIE2DtiFsbZpFkysPfnwb4g6i6BAaTQAjCwUqvO4UKKiYifWn5LoTmls6pmv5zPLA==
X-Received: by 10.112.14.39 with SMTP id m7mr10806944lbc.20.1456938600490;
 Wed, 02 Mar 2016 09:10:00 -0800 (PST)
Received: by 10.25.18.207 with HTTP; Wed, 2 Mar 2016 09:10:00 -0800 (PST)
In-Reply-To: <1456919186-5538-1-git-send-email-christophhoopmann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288131>

2016-03-02 12:46 GMT+01:00 Christoph Hoopmann <christophhoopmann@gmail.=
com>:
> Signed-off-by: Christoph Hoopmann <christophhoopmann@gmail.com>
> ---
>
> Changes since v1:
>  * Imperative in commit subject
>  * "Signed-off-by"-line inserted
> ---
>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/de.po b/po/de.po
> index 8c5f05d..a6b7bf3 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -12079,7 +12079,7 @@ msgid ""
>  "option."
>  msgstr ""
>  "oder Sie sich unsicher sind, was das bedeutet, w=C3=A4hlen Sie eine=
n anderen "
> -"Namenmit der Option '--name'."
> +"Namen mit der Option '--name'."
>

Thanks!
