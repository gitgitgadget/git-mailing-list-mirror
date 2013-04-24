From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 03:36:30 +0530
Message-ID: <CALkWK0=6A8z9HkbE=giU1BRDBq=0Hmkvhu7Eh=vAyARbs9Qt3A@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
 <7vtxmvbukv.fsf@alter.siamese.dyndns.org> <CALkWK0nmJPMJEotQ=-sSA5jXWd85mRk_Y+tbYHj1sr6ddJZsHg@mail.gmail.com>
 <7vobd3aab6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 00:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV7qR-0002My-4V
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 00:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758476Ab3DXWHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 18:07:12 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36503 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758424Ab3DXWHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 18:07:10 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so2812420iea.10
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4YgobNxATHUZZd+yNFb1lH9mcrzl4T4F++ntqsURFak=;
        b=SiXB3QLj75OGy3juAhkEXPwNXhMdipYbSNCgeE/3gEIYDq46mkmV+GjGJwWTv0PAgs
         +iaZC6XT3GzND9Z1pTW2BUc0x7GFwdyYIE15jKv1wM9VUqXG5oXrKFMbJuVwP9dDfLAv
         Bfl2koG8Yz8IHV7T4QGgwTA49YPw5EXmoEOWLHh4nt1CNPPjEXcjT1O3e6mK+LAvPnbO
         RdzLEok6PuNuiXDg6yOhylKOiYBtthPeD5C1bZLkkYU/SswWtgEaOoL2qM0k5pQ2Cr70
         as2AhzYH44G1EJ0ILLELXQ84BgNsyCRnLpS9CYf8zad421XMx9lyhcyABVBFDTu2WoM2
         TClQ==
X-Received: by 10.50.55.73 with SMTP id q9mr23744985igp.44.1366841230343; Wed,
 24 Apr 2013 15:07:10 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 15:06:30 -0700 (PDT)
In-Reply-To: <7vobd3aab6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222331>

Junio C Hamano wrote:
> My Git time is more useful to the Git development community than
> educating somebody with demonstrated lack of design taste by calling
> the "log ~" that has an irregular default "beautiful".

Why are you caught up in the character and the defaults (I just put
down the first thing that came to my mind)?  What I'm calling
beautiful is the idea to be able to tersely express "I want to know
what changes I made to this branch".  We can change the character and
the defaults; do you think the feature is useful?
