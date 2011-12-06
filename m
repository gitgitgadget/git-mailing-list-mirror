From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Yo dawg, I heard you like trees...
Date: Tue, 6 Dec 2011 11:04:45 +1100
Message-ID: <CAH5451nfXe_W7QA-WFP-_-q7OryMzNgSrO4EWpqaP97YrspyKQ@mail.gmail.com>
References: <20111205235740.GB27318@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Tue Dec 06 01:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXiX5-0002ww-Ld
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 01:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770Ab1LFAFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 19:05:08 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54708 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932738Ab1LFAFH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Dec 2011 19:05:07 -0500
Received: by lagp5 with SMTP id p5so1348142lag.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Wn3Lv51ItaGZY1koxIoq8gvquBi3GiWuX+Xl7QJns24=;
        b=aU6amklH8FyRb8udd72Vdj0hNLNzN4Rj/YfS/JdQwAc4gRqW4Z3c/Y+gPA/VVngDkp
         7zMiLE40QJUY5VWOewHuc+WU/VZ5lBIxcATPqwkOH41WGlFe5blQCJoIsznuNU18w2Gg
         e/7bQAOzmSYYEEaShE1RJG8uROwW9GVYB/UP8=
Received: by 10.152.105.211 with SMTP id go19mr7479931lab.31.1323129905364;
 Mon, 05 Dec 2011 16:05:05 -0800 (PST)
Received: by 10.152.22.38 with HTTP; Mon, 5 Dec 2011 16:04:45 -0800 (PST)
In-Reply-To: <20111205235740.GB27318@thinkpad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186301>

The difficulty in doing this is essentially the same as breaking
SHA-1, so I doubt anyone has seriously tried to do it.

Regards,

Andrew Ardill



On 6 December 2011 10:57, Sebastian Morr <sebastian@morr.cc> wrote:
> Just out of curiosity: Do you know of any attempts to construct a tre=
e
> object that contains itself, that is, references it's own SHA-1?
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
