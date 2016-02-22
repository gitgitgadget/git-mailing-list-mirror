From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Mon, 22 Feb 2016 16:28:32 +0700
Message-ID: <CACsJy8BzkWSc11ODenEuGBBta+dkLS893o7oRS57_ctoB5ie8A@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
 <vpqd1s2e74l.fsf@anie.imag.fr> <20160212130446.GB10858@sigill.intra.peff.net> <vpqd1s04zzs.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 10:29:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXmnr-0000m1-G5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 10:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbcBVJ3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 04:29:08 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:32840 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbcBVJ3E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 04:29:04 -0500
Received: by mail-lf0-f54.google.com with SMTP id m1so90479126lfg.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PckPrJhlIu277a1mbrxD76d4zKA6RO71O2LAgvr1f8A=;
        b=o7cj8y0MAt8AwPQ3V5Cvn1EATdDAKAs1FMIs09XmX1xQEic1gGSdQ46OMjtHYDmuLh
         LNEbJU6S7QbRwkQDnm4RtR1/rqR4pL4Oo1uuvbuVxsGlp4HlfUoIsOxCn/kpIEQ7jESe
         y4HU9K6tTrtLgr/DhIsO5K7ljLQIGxzMiNbponEuEcrGWKvFFrSYJrmTAXPFBahhc742
         Z8tiM3uMItgJsZ/NNh1i1bP1ua8uSEva7nbz/XDVL69zBPz24L5r5l1cVQLUVqkt/pzk
         hCqP3iT9L6nTbPRcWhzOuOVR2ITNwpOZWnKTp9UwVvbPoUSHRywK0ZZkVaxk9Ve/9Ux4
         RUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=PckPrJhlIu277a1mbrxD76d4zKA6RO71O2LAgvr1f8A=;
        b=DpRnPhLmZlre96FHnOjNabQRxEmlXVX+a4+F3SeJmajjVz+fRFV4H55awXvtBRcFgo
         ii3c+IyNyfMtw4aF8RJENVBSHIWU8PXpxSjt0h+rxwj2Tp8z8YL7o9p64Ut64tTicHMD
         CT+s70EyZE4mydpn72l2iuduoQ1fEONXkeevq2/GKVU48DOSer3a5GlR4TjrZwIo1t6E
         +gxxNjuit82H79gQ6zeTbD5RQMh8QKPPl5nFGmIIXOpqxqsgrtiCKdaRt2kI/qtqPH4H
         BFu4ppKh4mUC/kr0IvKgVrV2Qw7Nlqv2f1IhG1b78zH73/YAHAtgqSdSQBE/tnIJpW9H
         j7oQ==
X-Gm-Message-State: AG10YOQdPcdzu2YXvGmxdo6C6/VuTxoat2keo02pRZFgfp3jtY+LcuhuAseLqc/XPpZkull7Rl3fTP90hUo+LQ==
X-Received: by 10.25.159.68 with SMTP id i65mr9718736lfe.94.1456133342168;
 Mon, 22 Feb 2016 01:29:02 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 22 Feb 2016 01:28:32 -0800 (PST)
In-Reply-To: <vpqd1s04zzs.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286899>

On Sat, Feb 13, 2016 at 6:21 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Less urgent, but we need to add more stuff to be credible:
>
> ...
>
> http://git.github.io/SoC-2016-Microprojects/ => I just did s/2015/2016/.
> I think most projects are not valid anymore, and we need new ones.
>
> To all: please contribute to these pages, either by sending patches here
> (CC: me and peff), pushing directly if you have access, or submitting
> pull-requests. The repo is https://github.com/git/git.github.io/.

Idea for microprojects. If you compile using gcc with -Wshadow, it
spots local variables that shadow another local or global variables.
These are usually bad because it makes it's easy to make mistakes when
changing the code.

_If_ you agree shadow vars are bad and should be exterminated,
'master' has 94 warnings spreading over 49 files. A student can pick
_one_ file and try to fix all warnings in that file. There are many
possible approaches (rename, combine vars, change scope, even
restructure/kill global vars..), plenty of room for discussion.
-- 
Duy
