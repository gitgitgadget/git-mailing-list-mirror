From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 20:19:29 -0500
Message-ID: <CAMP44s2VnXV6YqgN4EqduzQS+UHFuu0XDsAzQQU5bKrEfOK0VA@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<7vsj2e1d83.fsf@alter.siamese.dyndns.org>
	<CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
	<7vd2ti19zt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 03:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXK3-00051P-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758415Ab3DZBTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:19:31 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:49165 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758323Ab3DZBTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:19:30 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so2761928lbi.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=iANsqDrhViYCgJ6KhFNhpZoJ5RuzeOXC8++8RDOX/04=;
        b=gh/v07Y24ccGufS+4ghN6KO01Y05G1NKs463R3ofRlggniGKrIvaYLByD19wckiVAk
         pGBYU5oLW1zX8nRMc9vN9hMI3td+Jtb+BCioHbenwWZtINJ1r3eDI1gDeg7RDYbFflY0
         uDk/4L8/w1sPBxSecF4W7dF9HR84cixsZMSJAJUhpcmmCv+YmeuENghjupY4P+VUAPd+
         TJZJTePpgZFu/8JTF+e3+DYywYksN9a78JU6AjOOoTLKCgUiYFD/JYeNoWQjRfFSmBUK
         54Dj1fg6oaZWE3WNg1wZBik0qqrjWMxIWxT2LO/v9WScYDuSUG5FWr38bDkXWC0chlvz
         9cwQ==
X-Received: by 10.152.5.134 with SMTP id s6mr21529504las.24.1366939169142;
 Thu, 25 Apr 2013 18:19:29 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 18:19:29 -0700 (PDT)
In-Reply-To: <7vd2ti19zt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222504>

On Thu, Apr 25, 2013 at 6:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> You are missing my point, this is *ONE INSTANCE*. Show me another
>> instance where a reviewer complained about the lack of a descriptive
>> commit messages on *remote-helpers*.
>
> You are the one who is missing the point.  My message was about your
> patches to _any_ part of our system, not limited to remote helpers.

I still see "Re: [PATCH 1/9] remote-bzr: trivial cleanups", if we are
talking about something else, let's do so and be clear in the subject,
but I don't see what this has to do with this trivial patch, the
series, or even remote-bzr in general (for which nobody has complained
bout commit messages before).

-- 
Felipe Contreras
