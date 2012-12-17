From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: problem with BOINC repository and CR/LF
Date: Mon, 17 Dec 2012 22:38:49 +1100
Message-ID: <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com>
References: <50CEF289.4040503@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkZ2e-0001P0-F2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 12:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab2LQLjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2012 06:39:11 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:55377 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab2LQLjK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 06:39:10 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so3788439qcm.11
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FNzLCgLMQCPoEmpvHC+7pFcK9Jj8sV6oARi9OD8cy20=;
        b=u73CFi0zLG82ZmQAErMZAZBT5kYj3uucBSrgSiCpqX5Uxcm80dDef/dS7/1YIAzskh
         +M+rU25aheBaGhdygYOlacbRnl7GlFf0Uh/vW4M0infmlY27CRI/sL4roP+RLNK3r3LA
         EQ4wjRFdJTEQtyEhfwWpVM2IXe2ZakPpyTFWsKtQ1iKgM8CbcfN5owDpbj90v0cLPxEU
         CgwIOWPI34LYbOtdh93vhGLgBoeyn7Yp4e2F5tSk75CD7/YJBJfLz1Ckd4b6Wz6ulu9q
         Kd+lhUbMO5C/uR1BbSznIpxfjGlxp+J6+k4XXapUPpINxvQXebgA+yXbMPNY8+iejKAL
         xmgg==
Received: by 10.224.223.80 with SMTP id ij16mr5814586qab.8.1355744349701; Mon,
 17 Dec 2012 03:39:09 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Mon, 17 Dec 2012 03:38:49 -0800 (PST)
In-Reply-To: <50CEF289.4040503@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211677>

On 17 December 2012 21:23, Toralf F=C3=B6rster <toralf.foerster@gmx.de>=
 wrote:
> Hello,
>
> I'm faced with this situation :
> http://lists.ssl.berkeley.edu/mailman/private/boinc_alpha/2012-Decemb=
er/017371.html
> and even a "git stash" doesn't help.

Hi Toralf,

That list is private and not visible without an account. Can you
transcribe the relevant parts?

Regards,

Andrew Ardill
