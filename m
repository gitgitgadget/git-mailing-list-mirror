From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 2 Oct 2012 22:26:40 +0530
Message-ID: <CALkWK0nA3mCk1dFoR7XXn3DOn=KauvFCzT3-skWMpzcxujiXOw@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
 <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com> <vpqwqz89617.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5mj-0005Re-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab2JBQ5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:57:04 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:58314 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab2JBQ5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:57:02 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so746032qad.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+sA/WWhz8t5Z1g/6cscJilWzw9snN9E/GoNWuuxzYAI=;
        b=acqz9jWzyxSFxDVthB55lhPOvMNYb2gr72gbX7SAI8hY8CcgKHIEQr1vPQ5hwP5T51
         e8O7EbWas7J/xywYE//XJGN7mU2iykJfnJcL1GmZvxXTIxDJg187EuMJ9HAXNhUDHYGI
         ckJ2KlHhqrCwzSpLCUp3mwDzR3dcYGil1QGMfSM77yrDkJNk1buAOpII2lEabE8WS41E
         eX/PPGMvA0UhRcUuqEWZcb1RxjenFjrunvfvYWu8tFNiuW0bhqt5mqKFWsO98+NJk0Zq
         gR50s3DhTkV5+erFf8obmmjC4y6uQZDAdzONh0QJGZ/M6w8cVsFQgXuWT7JspvegKFQk
         mCgw==
Received: by 10.224.192.66 with SMTP id dp2mr3108154qab.95.1349197021517; Tue,
 02 Oct 2012 09:57:01 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 2 Oct 2012 09:56:40 -0700 (PDT)
In-Reply-To: <vpqwqz89617.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206820>

Matthieu Moy wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> David Glasser wrote:
>>> Thanks Rankumar! There's also the reference in the "git push origin"
>>> example and the "This is the default operation mode if no explicit
>>> refspec is found".
>>
>> Sorry;  here's a revised patch.
>
> Sounds good, thanks (resend and Cc Junio if needed).

+CC: Junio
Please add a Reported-by: David Glasser <glasser@davidglasser.net>

Ram
