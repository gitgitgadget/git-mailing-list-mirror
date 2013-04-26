From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 01:29:10 +0530
Message-ID: <CALkWK0m+5CCUC+62wdyFbPL5Be7GS1P35suYoZxk6yzuVmqBLQ@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
 <CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com> <CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:59:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVooF-0007DA-RN
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab3DZT7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:59:51 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:59711 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109Ab3DZT7v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:59:51 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so4088826iag.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hZqsGZ9amYpXRH47/TknQJC/c4cLS4EBii0BNwMElNY=;
        b=j7eQx8DbS77YywxawzinipQp/lY5MmrkF2Z+KxJ6JkbxRsY/oQP37gBxXIfCSmSLx7
         FaoMq8FdBBh3z2mk25wTn7wR4q+gqUeXRjustxBVmxzu1ONjuVg2X/3pDR2uWjz8oQot
         0PNj3IOMnTqgDdKrWzRSF3y/+DyUGWU+kgMfinipkgcEmh2Zezu/hlwK/UxLl/1p2J4i
         pvQI4aotoN5EjwdIKPdAMTNb6NPK2H+T1+8sFXIegsJXpS7qG4uzQCERWojw0nzi4BHz
         W+nuPS50WMIssIa86mTB2w8nS33YnSvsSNd5vHSzXndnmMc0Dk3Ut/ReJQ1I6koJz/N4
         rlUQ==
X-Received: by 10.50.55.73 with SMTP id q9mr2878814igp.44.1367006390948; Fri,
 26 Apr 2013 12:59:50 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 12:59:10 -0700 (PDT)
In-Reply-To: <CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222569>

Ramkumar Ramachandra wrote:
> Diversity is certainly healthy, and I it would be nice to have you in
> the community.  We just have to find a way to keep the conflict down.

After all, what are we asking for?  Better commit messages.  Why are
you making such a big deal out of it?  You want diversity in "length/
form of commit messages"?
