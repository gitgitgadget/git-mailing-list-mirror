From: Sarma Tangirala <vtangira@buffalo.edu>
Subject: Re: git diff bug?
Date: Mon, 10 Jun 2013 10:41:04 -0400
Message-ID: <CANd8icJxGO0r0iezB0hO+OhFFATDG=vV=jUJNGROs+BGMYNmzQ@mail.gmail.com>
References: <CANd8icJ_1mqT9m-n3wPPdjzG1oNjwxfQeUA6YL6KVxbq0iEa1g@mail.gmail.com>
 <51B10236.2030009@ensimag.fr> <7v4ndayjdt.fsf@alter.siamese.dyndns.org>
 <CANd8ic+6AtWgbK3S7DMkaOz7K9WJYdq8ozP9mesc-vJRhxLjqg@mail.gmail.com> <51B5CA2B.101@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 16:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3Hl-0008W7-V6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab3FJOl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 10:41:26 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:57866 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab3FJOlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 10:41:25 -0400
Received: by mail-vb0-f53.google.com with SMTP id p12so4407685vbe.12
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 07:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=D+bmRv2gN19GBjmA+nykNOPRNb3BnNNb/F/KPqEBjTY=;
        b=bDQSnVSrVZcmHW9wr1Dr77QuwjLEMFMEZ/sYdn+9Ake8dTOx6/b3wwdyi9jQcphwvO
         9ac2sTVEIoh7tdTp1kTDO4AHrDSOAIDBahk3aFMkn/9kDK9oku/83yxIS1flat01DK04
         7mL5Ppo7e4U9s4fMkWp2d3hn5F4tVh7T/ePFJrjArKQ51DPdvZQPJdPh6l6uy/HjZ8p4
         slAlXSSYId5vTEqqRkvKp6/EH5aTuP5nmx/J+RytpK//CoFBCq3wv/xhCxRnlQ1EKRqi
         fNojTwvTJJeHk07nXD4/xluNAwRhaDg2JBB4wKBeEoD8m4KzG4QkucoQE57Ua5F/fKFf
         AuvA==
X-Received: by 10.52.243.234 with SMTP id xb10mr4926076vdc.68.1370875284127;
 Mon, 10 Jun 2013 07:41:24 -0700 (PDT)
Received: by 10.52.23.143 with HTTP; Mon, 10 Jun 2013 07:41:04 -0700 (PDT)
In-Reply-To: <51B5CA2B.101@ensimag.fr>
X-Gm-Message-State: ALoCoQmR1M2wd6hnk+3cH5qUkAb2BvvHeBggZvjCRAz4q1U0XrkKc5Jc3wnaVS6HhCq4BtZYdXmp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227295>

On Mon, Jun 10, 2013 at 8:44 AM, C=C3=A9lestin Matte
<celestin.matte@ensimag.fr> wrote:

> Since nobody answered you (publicly at least), I will try doing it my=
self:
> I think the best thing to do if you want a feature to be added is to
> come with a patch and request for comments on it. Then, people will
> discuss it and decide whether it's worth adding it to git. So yes, yo=
u
> can try implementing it - all work is welcome :)

That sounds great. I will try implementing and send out a patch soon!


--
010
001
111
