From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/7] i18n: rebase: mark strings for translation
Date: Wed, 25 Jul 2012 04:56:52 -0500
Message-ID: <CAFzf2XxTs1ynyjxRshrbOgieq-ryzBoY_p7EoGpmrPDyQomU-Q@mail.gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
	<915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
	<20120725042134.GA3055@burratino>
	<CANYiYbHnv0JppT64cnjzBgRq7_pRFHN5WMy2SAVj2GzG+dWBaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 11:57:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StyL9-0001qY-41
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 11:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab2GYJ4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 05:56:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35553 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab2GYJ4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 05:56:53 -0400
Received: by yenl2 with SMTP id l2so483193yen.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8o2ECatbCTJCQxcj0bttNE1sMqXBNWYRxajtWLyoZd8=;
        b=gip9Wom5GKRghRHC51uWjP2LaGUDz+CjclWFz3NtL7Bln1RkbFFlRDQFZzhs4xobiv
         alFkVrJ8m2EJS1LhJQpJ0X0g7O7rYxLBqr/Xex59v4O/hSC8d0k02tg1RHXxq9p1NKwr
         OzP+yOZign6MM8FU2c4NYxOd6I+hGz+Sx1QqKB9OWNgXrihxFx7N3zKm3cK4966pOP8O
         KIhjmJkKHRxFsJSwksyZi2mf45RCGa0J5CSBFyQK+WHi0yCOosDhk7KeDk5Qx3nKM/8B
         WScUlZjUxi0wXnGMtJjKd8e/QYgcozb5mLaR5N6/G7uVLbEBSBZ06eCtXp+WvmUyDviG
         v8gw==
Received: by 10.42.197.197 with SMTP id el5mr23481746icb.35.1343210212927;
 Wed, 25 Jul 2012 02:56:52 -0700 (PDT)
Received: by 10.42.28.68 with HTTP; Wed, 25 Jul 2012 02:56:52 -0700 (PDT)
In-Reply-To: <CANYiYbHnv0JppT64cnjzBgRq7_pRFHN5WMy2SAVj2GzG+dWBaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202143>

Jiang Xin wrote:
> 2012/7/25 Jonathan Nieder <jrnieder@gmail.com>:

>> I haven't tested or reviewed this patch in detail, so even though it
>> looks good, I'd prefer it not to have my Reviewed-by.  (See
>> Documentation/SubmittingPatches: '"Reviewed-by:", unlike the other
>> extra tags, can only be offered by the reviewer'.)  If you'd like to
>> credit my help, something like "With advice from Jonathan." would be
>> fine.
>
> How about Acked-by: ?

I'm not area expert so my ack wouldn't count for "git rebase" or i18n,
anyway. I'm also fine with going unsung --- too many names add up to
so much noise, and in general there are some names (author, bug
reporter, and so on) that are important and shouldn't be drowned out.
