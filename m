From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Thu, 11 Feb 2016 09:36:40 +0100
Message-ID: <CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 11 09:36:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTmk2-0005B6-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 09:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbcBKIgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 03:36:42 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34833 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbcBKIgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 03:36:42 -0500
Received: by mail-lf0-f54.google.com with SMTP id l143so27071360lfe.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 00:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N948AbkvjGUbBg6Q9u1SvK073YoJJl1snGg7V1O+6Mg=;
        b=H3oUFtbJOA1zRtTdvMXaj5OyWT87OEMR9fW9bJLLGVvNabLI6OTpKjWc3UpsIKegNY
         WKPT4Mc6W3UGD6R96nIOUKTlAV2EY40s3UDB7/HZk79NO04AWsjVOv/oVCYZFUQ7u9uC
         yw5gn9tgvcx9K5dSSg9EnpnFQnHMnT7whL1R9NGywaAJ5HXKOiLeLxqxXD7qh5VEtt6d
         UUE3i9AW6uVUMULN4c/xaMZZZbkID5DtI0RnzaDd6DybtLp9KnbDf66RxUPSvIPxkJ7r
         5kVD+zTPjU4T3EjUyOsLCotY/F2m86DeT2d6wc/c+0ti7O6NkXpl7k8LqMnzL8Q0k9H8
         V48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N948AbkvjGUbBg6Q9u1SvK073YoJJl1snGg7V1O+6Mg=;
        b=NQmyFcjN2Tyh1VaK9EEo4X4TaXkacjotfROVVVjPyHhwN3aMz86K+zrr+i/tbCf/N+
         a9jAa29iKw6VmCGwMdMGcHwsgIcfBx3/wk6mrX42vYs0aRu6ZSC00uoJCr1I2fFQW5QJ
         1GVkN5LkJOsp0TJUXlL3sQfwfWlqT8er7QuM2FjhOLmqV4C0vesHVNJEWi84VF7HA6P0
         zEB1WAg+kpMufx2W3zUsVHwgnLSfrhFsUeYKtNLXLC+TMiuJHdzVrpZl3jKb0mprUOG7
         L7704kq92+bs51cooj1QPVRMPbQf7C+69c6Bk4DvRXxxo47lfSLLZ1acLZRhu6lJBzBK
         MwQA==
X-Gm-Message-State: AG10YOQSJg2fyJ2h8vbSfFw5oGV5LlxEltLQ3zUFGcNgsxsEED7hDx3/0tyrBKzce6rK1r3wYgW0S3oz1CKysg==
X-Received: by 10.25.42.18 with SMTP id q18mr18333574lfq.151.1455179800802;
 Thu, 11 Feb 2016 00:36:40 -0800 (PST)
Received: by 10.25.20.100 with HTTP; Thu, 11 Feb 2016 00:36:40 -0800 (PST)
In-Reply-To: <vpqoabox66p.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285950>

Hi,

On Wed, Feb 10, 2016 at 10:31 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> So, the first question is: are there volunteers to be GSoC mentors this
> year?

I can co-mentor this year too, with you or someone else.
With you I think it will work out even if you have less time than last year.

Best,
Christian.
