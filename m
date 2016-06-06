From: Stefan Beller <sbeller@google.com>
Subject: Re: licensing question
Date: Mon, 6 Jun 2016 09:48:27 -0700
Message-ID: <CAGZ79kY_gkmhyPuhojNKz2CeHtu3ehc0veOVx=AFJECaF=esUQ@mail.gmail.com>
References: <OFB3C912AC.C18AA58F-ON86257FCA.005A243D-86257FCA.005A6699@LocalDomain>
 <vpq37oqe0do.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Annie Wojcik <Wojcika@ntc.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:48:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xha-0005C3-7r
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbcFFQsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:48:30 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33778 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbcFFQs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:48:29 -0400
Received: by mail-qk0-f175.google.com with SMTP id u63so10105981qkh.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KBKXGIUDWJwhvECUyJQ7GlHW0/tbHA6eXSbrq32+0HQ=;
        b=TZbbTkagdfW0GJkN1Ytvg5+JdKtWsuKitoPFwyZZIogaM+0IZW6J284OSMwEG8vecN
         vbO/v+g9Dw/6z+cMvlVhp382kRsjWBAdcRFsiNnvWNRVlpakBE5R8Cfas3AjV+XPTXmw
         5vGwuZN02OtmUywMo9HPA41XzTKh5zEeJuWTVUcZgZ4twnf5yc2hOCxGR/RQimoMFfJO
         +qyH+zWt5nYT+XAKUOr1B9vrEGW9mVZzOXXWMu0Vx2o663JAumnfPKciYiUTpZWV3xT2
         KZ191vC+H/fOmv2HlygFDZEkSMNHKqCM21km2pvBklitzr2ZM3rAec9u5GsucQl+FTvB
         wnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KBKXGIUDWJwhvECUyJQ7GlHW0/tbHA6eXSbrq32+0HQ=;
        b=g4vMA6OAL2uBUahLMVKj/rgX5c/CEizJQ4jnxi+6x+LcKmJT+NP3UlIg6HvFp6kP4K
         WzCZlESHUgm//AjDZJeWiODoO59JVzsA8rnkTouPlguNhjezP49p3le6wEq0qCCF/Uh/
         VBPyGVTbETqILNaN07z4K/q7H99GORFrSVqLIf8WaDLMtK4LgAbjjQCprUpSN4GkE4wl
         Mp+qC65a68VJ9Qnfr1qC3ETOSBZYzoeVaLypYuqJlk982bqdN63UKfriQFEoLN3p1cIT
         ZpegyD6Zqy0of3xFt2PwmQlbIRfgd6WhKY9mx9ZGyDVOWsgLvtEy/5xq1HpK03e7V6gW
         J3YA==
X-Gm-Message-State: ALyK8tK8F61GigufH34IAQzocecfMwDAAYSOu9Q9zdZW7lc/WIsbuluzXr/4fXladIaIOEkUyekr5BwkbTlpfNxT
X-Received: by 10.233.237.14 with SMTP id c14mr16188081qkg.88.1465231708336;
 Mon, 06 Jun 2016 09:48:28 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Mon, 6 Jun 2016 09:48:27 -0700 (PDT)
In-Reply-To: <vpq37oqe0do.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296537>

On Mon, Jun 6, 2016 at 9:40 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> "Annie Wojcik" <Wojcika@ntc.edu> writes:
>
>> Hello,
>> Can you tell me if this product is free for educational use?
>
> Git is free, period ;-). Both free of charge, and "free as in free
> speach" (http://www.gnu.org/philosophy/free-sw.en.html).

A quick overview:
https://tldrlegal.com/license/gnu-general-public-license-v2

In case of doubt however the actual license should be
read and interpreted by lawyers. :)

Stefan

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
