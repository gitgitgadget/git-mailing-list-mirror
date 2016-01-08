From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 10/10] t/t9001-send-email.sh: get rid of unnecessary backquotes
Date: Sat, 9 Jan 2016 00:19:16 +0100
Message-ID: <CA+EOSBn7PwAJRZrORhk=2y84AwG978GGLR6ghp+=hkLHEu3YrQ@mail.gmail.com>
References: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
	<1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
	<vpqa8ogdsyr.fsf@anie.imag.fr>
	<CA+EOSB=jVho9XCAG0Q3P6dvH6A99b5yB7FcyxkS3DtxupBeoFA@mail.gmail.com>
	<xmqq4men1yuw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHgJd-0004uM-75
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 00:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbcAHXTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 18:19:19 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36422 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbcAHXTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 18:19:17 -0500
Received: by mail-vk0-f66.google.com with SMTP id e64so577687vkg.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vzeBsbMYaiUxSRCiHL4hE7nwYUh2wZyAhkU6H/yvw2U=;
        b=egG8UoVjFqOLqvFwwqjmlJS7fjG7477CehTtAre/e+hAcamhrZhEGPKvJapzcKCHkb
         g70XHPVhsLfydrk7Ai4P5lAVGd+fPMyOf6B+LjhJuUx+aAb80Dh3iNIavQHNJgLEZlUd
         xTCSSANQZ4OlP/q7sFmAC1jrlz8hcLytF1+EG6X3d98XdMlCVx44A2CKqp1xPOu8S5Zm
         ngHqxt8b7y46rCklfPDXPnTwoYb+kaEQrruvtIdjHGDqUKxqDYHbbhhUIl41K3GULyrz
         iAi5ST1iYESH24IVLFo0qHt5gmDu8PF99iee+pZQe04vx71G13os5S4uybacF0aKhI4p
         mb0A==
X-Received: by 10.31.136.16 with SMTP id k16mr70708646vkd.35.1452295156532;
 Fri, 08 Jan 2016 15:19:16 -0800 (PST)
Received: by 10.31.56.209 with HTTP; Fri, 8 Jan 2016 15:19:16 -0800 (PST)
In-Reply-To: <xmqq4men1yuw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283588>

2016-01-08 23:37 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Thanks for the review. Junio you kindly remove this patch?
>>
>> Thank you all very much.
>
> Done, and thanks for working on this.  I am guessing that we are
> very close to done, seeing that you now reached the t9xxx series?
Yes,I've almost finished. Are missing aprox 22  patches,  in addition
to incomplete ( and wrong ! ) patch  we have discussed but I have to
control them.

Best Regards
