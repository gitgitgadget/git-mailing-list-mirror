From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 01:33:52 +0530
Message-ID: <CALkWK0=O0kp-d5pUNxMpAp4MzxORSod2H9wnMz37dLicm3mOZw@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
 <CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
 <CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com> <CAMP44s1RTm3LRaL71U1LQ=RvA1qyOSQKsk1ptXeNP-GRk3rVrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVosp-0003Wj-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab3DZUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:04:35 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38618 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab3DZUEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:04:33 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so5466481ieb.11
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Y5JWhMsSONyZ6StkNz60kpfF9MVMgsS8e/TvrobGWas=;
        b=Mx0a3Dh1wQKwu0o24KP3PtZ7KuCj7bikGnxLH9yLdGlyM1eaGbXWXaHG227+g8DZtn
         8VUjOe58JLkbPsa0JJI2jGddVjom0b1rmXM2PWxzdr1lBEbyYzSbZoQAFWIiVM7hCEmm
         lflWVEYSxFE5cAMjETC8KfCHe/OxSE3AgWSBPT/Ift+k1RKhQL6An8qN2GKvndw/7H0z
         1ohE0LxvbFJACwZCG3qUzSBm30b48egM2hN1KJMxwmVvAhXQuPIS7dTITdjyvW3SgQ5F
         Yrs7LcEzRJRRKdLTWEAnT7Vikl9tV3b7M34v2I6De+SpDLXn3TB+n/kBGeH8xo5UhbVT
         tjxg==
X-Received: by 10.42.123.66 with SMTP id q2mr19482532icr.12.1367006672943;
 Fri, 26 Apr 2013 13:04:32 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 13:03:52 -0700 (PDT)
In-Reply-To: <CAMP44s1RTm3LRaL71U1LQ=RvA1qyOSQKsk1ptXeNP-GRk3rVrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222571>

Felipe Contreras wrote:
> A fine way to start is to not rattle away in trivial inconsequential patches.

I have something from Linus (TM) this time :)

https://lkml.org/lkml/2004/12/20/255
