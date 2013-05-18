From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: User experience: git-remote-hg
Date: Sat, 18 May 2013 17:30:58 +0530
Message-ID: <CALkWK0=MrUE6POyVhqw5R+mAnk6S3TT0cn5vOcJSbXbJ5zWuzw@mail.gmail.com>
References: <CANxJqTwyYuQO8bXP=yV+-aPMMo4=KB08XfxehQZZM3nC+UkvPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Samuel Chase <samebchase@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 14:01:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdfpZ-00015x-Gq
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 14:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab3ERMBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 08:01:41 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64952 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab3ERMBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 08:01:40 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so10973032iec.20
        for <git@vger.kernel.org>; Sat, 18 May 2013 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XswjkBlXMeLTudG9YjlYfoD8nGCDpPf7yE+aR0xHzfk=;
        b=Hz6uXRDeaS8B93ZCouweaF9tCwMMISV3Y69y9E3jrfSxoZZylApTkYb+T9ZnkAOfSD
         2GztaVNpxm8rnwlcTimosSip5peK95dMHXqJLemlyZwX4ki0S67LVLELXieN8il+unsc
         FTWKhIX+Rr00JljDr3SvS72cQ/dkoqmlDoOLaPjlhPjbrtlAmhFwLXo0sO0JeYNgpoaq
         9COY+B94vJwSjvOOG/G17Kl7K8pheqVjcxa5DVAdPU4TVbw3e9x3+5MynYPawHWjo0kt
         E875EXwlA0DcZMuv1Je6lE76kR4+bWrpo1dxRRTmr0HZZ8/4pKxPWF/+hVdYMUwZ21GG
         /rrA==
X-Received: by 10.50.66.197 with SMTP id h5mr901371igt.63.1368878499819; Sat,
 18 May 2013 05:01:39 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 18 May 2013 05:00:58 -0700 (PDT)
In-Reply-To: <CANxJqTwyYuQO8bXP=yV+-aPMMo4=KB08XfxehQZZM3nC+UkvPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224790>

[+CC: Felipe, the author and maintainer of the script]

Samuel Chase wrote:
> I just used git-remote-hg to convert a small hg repository.
>
> It worked perfectly.

We'll be happy to address any deficiencies/ warts you find in everyday usage.

Thanks.
