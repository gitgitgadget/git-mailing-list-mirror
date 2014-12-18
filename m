From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH 1/1] Documentation: config: typo fixed
Date: Thu, 18 Dec 2014 20:03:42 +0600
Message-ID: <CANCZXo7cy2=85M6==ZhQNHgMzDc+YOd0bTZ6qzNV8PqV6d+FbA@mail.gmail.com>
References: <1418902079-27794-1-git-send-email-kuleshovmail@gmail.com>
	<vpqsigd5b5u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Dec 18 15:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1bgB-0006SB-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 15:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbaLRODn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 09:03:43 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:61520 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbaLRODn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 09:03:43 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so3359232obc.7
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g8+bKKEmmb94CUYWQKjZR5X7/mZ4x+eIP5lJpi7L1eY=;
        b=HyhSV8d+dABHDlUY1Iw/P18rjxuHRTQJ55wnz7tkR56yTA24TxSdyzm9V4Pb3JGICt
         FbawnZaeAnKtOKwqgZA4uFQ4IuZErzREBIS5dlq0faqiSNf8VT5U1C/NeL9lara8lK/i
         rLtVRqhl0CUBHqLjeXkaB/kZS2pNpRNsh8sA0XLmqxcWVAJdh++/EmuMbXUPor3AQSMl
         dh3QqJ5Kxuh4fy31hNm3SinBPZNk4eb1SCO5wlPHZcwm4F2ga1ltvS6EF+1Et6feTRRw
         d1BPDHXzld+KqJeUCXSDrZEdm5L7t+lKFOy8M3yR4eecmzsQZMsmNlqlo8F//tuIXVpk
         jh3w==
X-Received: by 10.60.92.40 with SMTP id cj8mr1370674oeb.43.1418911422593; Thu,
 18 Dec 2014 06:03:42 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 18 Dec 2014 06:03:42 -0800 (PST)
In-Reply-To: <vpqsigd5b5u.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261526>

Ah, yes, didn't know about:

>config variable names are case insensitive

so, you're right, thank you.
