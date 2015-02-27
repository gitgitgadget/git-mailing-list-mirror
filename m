From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: fix negation for commit -a with paths
Date: Fri, 27 Feb 2015 18:31:40 +0100
Message-ID: <CAN0XMOJvsF+wHUqOXMgz2Rjhz8p1XjhmbFwCv4BXANDTSAzLww@mail.gmail.com>
References: <85fb5a9d3cf3bc911faa0d3ad193f5697837ff93.1425054567.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 18:31:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YROlO-0004r7-IL
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 18:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbbB0Rbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 12:31:42 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:42922 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbbB0Rbl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 12:31:41 -0500
Received: by wiwh11 with SMTP id h11so1827977wiw.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 09:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=D554Ndwcx7WY7fmyz6TTl4vKnWbuJm612jLQe5Ttx/M=;
        b=bUppon4qdxjazlu0W2VeAIcjPy0nJ5NiIVEgd6b4tXWJ8aUzv03gF6aQ4H3euCIw/a
         vNgwVnUt615mK+NMOCltclhFyTC83ztsCYA1kGPttuo9uwRGBiAIc1kimSpVLG7+a3Wr
         usVOfs3Be+gaorVsJyCqrCv/DkAO/cTfxiQ8cjWyk1i/c1ahrowT8s/5VhJZBi1iXD1e
         Bun/kunafl7IpynoW3pQyMZ/xH2HnYW35vAF8W2rbgMmcnotJ4a/U5qjMis0IY+Pyi+6
         02zuI1pN2vpUV8Osz6g/sxT2KS+08GBUkobbU1cP2dSTGvF21jOp+tlP7ulo/rGGNE8C
         NvOA==
X-Received: by 10.195.12.71 with SMTP id eo7mr30558040wjd.3.1425058300277;
 Fri, 27 Feb 2015 09:31:40 -0800 (PST)
Received: by 10.194.72.5 with HTTP; Fri, 27 Feb 2015 09:31:40 -0800 (PST)
In-Reply-To: <85fb5a9d3cf3bc911faa0d3ad193f5697837ff93.1425054567.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264502>

2015-02-27 17:30 GMT+01:00 Michael J Gruber <git@drmicha.warpmail.net>:
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/de.po b/po/de.po
> index 11fbd0f..aff3109 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -4613,7 +4613,7 @@ msgstr "Ung=C3=BCltiger \"cleanup\" Modus %s"
>
>  #: builtin/commit.c:1218
>  msgid "Paths with -a does not make sense."
> -msgstr "Die Option -a kann nur mit der Angabe von Pfaden verwendet w=
erden."
> +msgstr "Die Option -a kann nicht mit der Angabe von Pfaden verwendet=
 werden."
>

Thanks!
