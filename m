From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever the whole system is
 referred to #2
Date: Tue, 22 Jan 2013 19:44:42 -0800
Message-ID: <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
References: <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
	<7vvcark1f2.fsf@alter.siamese.dyndns.org>
	<775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
	<884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
	<2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 04:45:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxrGr-0003KQ-5q
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 04:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab3AWDoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 22:44:44 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:63406 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3AWDon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 22:44:43 -0500
Received: by mail-ea0-f181.google.com with SMTP id i13so2247560eaa.12
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 19:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=wws0R6PCb7s6Ox33Kg/C/6M+SSvDgCKzn46npROT4uc=;
        b=mJgnTszz2x7TatNGUnDUYQHjEV9Ue6s16bSWNLK483hBCel5oC43LPi+OkwBB5omDb
         AVTAk1cY0fTooMeuylgboZqaEVv3vDDkTYRKE/uTzJBm7Me6u0N33D4lcb3d5+xtiV5l
         tH/TdgfvPcI4Z5Zz4tNUTCwS6wsnw7wUqmCH8Id19T9NJlXqBBizY5hF72T1fp3mj58Z
         6PidkTh3/OxL025pVF0utIUBsuH4b8moB/g1fOP1hVYxtWqrR+Z0xsGO7J+cpSIlRGo5
         hCpmSVNkV+HjeqRRC0ZtWIbp7LapoLKLlcVyIFS6itoVb6C1Y51s7HEJawsZPbvtOvY5
         D3Xw==
X-Received: by 10.14.1.70 with SMTP id 46mr24718668eec.0.1358912682683; Tue,
 22 Jan 2013 19:44:42 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Tue, 22 Jan 2013 19:44:42 -0800 (PST)
In-Reply-To: <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214278>

On Mon, Jan 21, 2013 at 11:19 AM, Thomas Ackermann <th.acker@arcor.de> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b87f744..5a831ad2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
>  push.default::
> -       Defines the action git push should take if no refspec is given
> +       Defines the action Git push should take if no refspec is given
>         on the command line, no refspec is configured in the remote, and
>         no refspec is implied by any of the options given on the command
>         line. Possible values are:

This should probably be "git push" in double quotes.
-- 
David
