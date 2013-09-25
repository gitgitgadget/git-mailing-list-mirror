From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Wed, 25 Sep 2013 11:36:34 -0500
Message-ID: <CAMP44s3AtmJ7juRvfk4+StBqskv0tvukaLv9wMD0ymGVinOXGw@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
	<CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
	<CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
	<CAMP44s2j_ra_Tk_s-tjwwvX=T8y=bKPTaUdOQk1jD8QpUm+-zA@mail.gmail.com>
	<CAEBDL5X1QRLaTvxhEu4e5_NE5fEWc6fd60YJyA8wye4d4T3wpQ@mail.gmail.com>
	<CAMP44s2EtgXXdfa+QtUmmRh6wZ1fD8YTWtzLJ2mN6y_6faMM_g@mail.gmail.com>
	<vpqr4cdt0gk.fsf@anie.imag.fr>
	<CAMP44s3qv==GZt7BYMc-FuQvVoNGf3kkGAGzk=-=F4A8KZojKQ@mail.gmail.com>
	<vpqk3i5szng.fsf@anie.imag.fr>
	<CAMP44s05ggre-ZcURLyTyYsFG1_f=gVDW-dj2LsNK8_tGTqyyg@mail.gmail.com>
	<vpqy56ksx8y.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 25 18:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOs5E-00064L-81
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 18:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989Ab3IYQgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 12:36:37 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:61686 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab3IYQgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 12:36:36 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so72627lbi.4
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 09:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f/dO9YKK0tJwPT1S3MmjIIN6jAcpmCiv0K/AMNKEkUg=;
        b=NOdHydEXlDOPI0LFmnFMl9uqdMzTtYfOe+bAhUWQLDZiG6EINiEhZJx4c5onrSng2g
         72G87kUvN8ggzAEKoOOZoohRLSM1Er3qN5vqhWudXCWm66lQFHUZIVL2QeD5pmFAaaSP
         t1cthr+MXb0T4hrsmSbOdn6i0UhTNYD/9/11pn26jilyJUUX/R30ITj1y82l4ZHN8W5Q
         Fvi8sXV2Y97+P3hji0R+4apvJk+nevC1vdO2IwjzqtaVvAfJjwbfeOAc2s9xT6S15ZCk
         XhOYbmrMc/N2goZxIu25cBB1YywdhFbRXN94fZKXEWje2jhosO6ix1c5hrCUOhi2LzWi
         Y4KA==
X-Received: by 10.112.89.100 with SMTP id bn4mr137027lbb.16.1380126994566;
 Wed, 25 Sep 2013 09:36:34 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Wed, 25 Sep 2013 09:36:34 -0700 (PDT)
In-Reply-To: <vpqy56ksx8y.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235360>

On Wed, Sep 25, 2013 at 11:05 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Last time I checked nothing has changed, the default remains
>> push.default=matching.
>
> LOL.

I'd take that as an admission that you don't have any examples of
important changes in the past two years, at least.

-- 
Felipe Contreras
