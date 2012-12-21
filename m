From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Noob Question
Date: Sat, 22 Dec 2012 09:38:41 +1100
Message-ID: <CAH5451mZdwf-2d+XJTaLLhY0FjbpJTfCkzExw23FojQE08FHZw@mail.gmail.com>
References: <50D3B669.1030204@hotmail.com> <CAH5451kq8XwPTez0Jhst+rVCo=EteW7OMH4wr2a1rCXTW_f0jQ@mail.gmail.com>
 <50D463C4.6030208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: W T Riker <wtriker.ffe@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmBFT-0003vi-Aq
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 23:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab2LUWjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 17:39:04 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:61611 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2LUWjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 17:39:03 -0500
Received: by mail-qa0-f54.google.com with SMTP id j15so3843859qaq.13
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 14:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hSzAaKTeysuOy8Tj6+wOJ2GgvxqHbZ1U/CeUHVyqhj8=;
        b=0zh6svusY8KcXgebV8RPDmzbe9ytYeKKRcHieIFOtsUQJ6XtmUWapHYZgOqxoaSB01
         tt98EzSdMXh7ufipAyfZGQoh6NU4GaLCVwMD+dhEcvzsrURl/UvJ2sGg/p57cP7hXsM9
         lZ4IDyzlX9JeN47BLuA/LSRwWZ4q/tNMCV8RpWxEwFVWOX7ti+1IXZ5fmJu8r+2B7QEZ
         1OM+VBQsoNBiDscVuvSljWnLdBegjMMZlXGoUBsYmTWFgnNeRASa/9WSNIMzJ+6zmjCD
         HnWRXU40NaLQNs416UW9lCMk9qi4uRVzL6vtrDBEjeDnCEIzaldXV03suGLlrs/txzbU
         itAA==
Received: by 10.49.3.234 with SMTP id f10mr9095146qef.52.1356129541675; Fri,
 21 Dec 2012 14:39:01 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Fri, 21 Dec 2012 14:38:41 -0800 (PST)
In-Reply-To: <50D463C4.6030208@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212018>

On 22 December 2012 00:27, W T Riker <wtriker.ffe@gmail.com> wrote:
> One basic question, since I don't make changes from the Linux
> side, only builds, do I need to install anything git related on that
> machine?

You don't need to install it, but there is no harm in it. If you ever
start doing a build from the linux box and decide you have the wrong
version of your code, it would be useful to have git installed so you
can checkout the right version. Installing git is quick and painless,
however, so you can cross that bridge once you get to it.

Regards,

Andrew Ardill
