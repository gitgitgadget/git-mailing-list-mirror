From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 0/9] remote-helpers: fixes and cleanups
Date: Sat, 27 Apr 2013 08:26:26 +0530
Message-ID: <CALkWK0kgL_kUSUc2Y8aKah85P_X5u5g0nYNOw32Di-1xWH6X_Q@mail.gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 04:57:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVvK4-0007q8-CV
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 04:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab3D0C5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 22:57:08 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33892 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3D0C5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 22:57:07 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so5673190iea.32
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Cm7GSK7fTbzSoe1ARVtKf4k5no8sUxQJ5aJiFCqech4=;
        b=HV9e43zs7lqrpNW6lhDwWkGE7uDPG5aXte4lhAd6AKWI36UFGYIMKIdrx7vlCVS5xe
         p5lgB8ofgOPRLGIuWlsg3UKJm0McKbHw/DnSSfXKKp31bSPmMADFRq92dnwRjF5ASgbH
         LP7M59NPzdHicRdoQ8C91tyeXXQxFnsdFY4IHwK+eJyxDHt8gX2RPyGdzc6QesEQRQIh
         Qu+sFP6nWF2INe082JNW+fAHyucJfb8zgV9d9e4a5qeDJ9bJBl9Hhc8fl02mMtAVA+8Q
         CGWQJsgeV4B75RXWJXIQ/+wy7p28mZmm2BfjB0VBhYUzjpWUWz1+oGYD1RZq19D0idfY
         3Dcw==
X-Received: by 10.42.27.146 with SMTP id j18mr14397473icc.54.1367031426242;
 Fri, 26 Apr 2013 19:57:06 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 19:56:26 -0700 (PDT)
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222617>

Felipe Contreras wrote:
> Updated the commit messages, so we say Bazaar instead of Mercurial, and stuff.
>
> Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.

Looks reasonable.  Thanks.
