From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Can't Open Git
Date: Fri, 10 May 2013 15:51:57 +0800
Message-ID: <CALUzUxoYF2gr5HHpA5QxeNj-PBPvu0tRrMs46PFdDBE9dUiq9A@mail.gmail.com>
References: <B5C53ACE-2055-448A-B687-49775BBD0D14@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Esther Hwang <ehwang827@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 09:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uai7q-0006Ue-OD
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 09:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab3EJHwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 03:52:18 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:54602 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab3EJHwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 03:52:18 -0400
Received: by mail-ia0-f182.google.com with SMTP id j5so2039556iaf.13
        for <git@vger.kernel.org>; Fri, 10 May 2013 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Q50PD0STWcDaUODsAFqYG501expm7/KGKkNZj9shzhM=;
        b=W2AnQqFTfrZOV0d338ibMnsW+NRrGqnd4A8jV15x4yXRdTROYxOu1KYui9U/GnK4bT
         MLcMBgfGVtTKVuodG32ROrlytptmS4ZEF1mU2/nEthiFWv9NADGpZKcHQY5FrUxWDAbi
         p4Nd29kPVtgzJj10nsLJtZWCUK6sQwM50VLgtTQkjsPOLbfSioDmB4SWwxOj+IKg5dkw
         1Spw/FalaHDSbiNu7g96wmev/5okoEN1kW2dodq5K6JoKVZEJV6IwABwpkEtsEJQIsBs
         M+17qG2CLK5eo8YaSRjH3MJk/CTV06Th88vrgl/yIEwYKwsh6rTM78oEW3eEm4bFKy4X
         i/zQ==
X-Received: by 10.50.66.199 with SMTP id h7mr1113334igt.8.1368172337536; Fri,
 10 May 2013 00:52:17 -0700 (PDT)
Received: by 10.64.44.165 with HTTP; Fri, 10 May 2013 00:51:57 -0700 (PDT)
In-Reply-To: <B5C53ACE-2055-448A-B687-49775BBD0D14@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223824>

Hi,

You need to start Terminal to use git. eg.

  $ git init foo

creates a git repo in the folder named foo.

You can get a GUI to run git too: http://git-scm.com/downloads/guis

--
Cheers,
Ray Chuan

On Fri, May 10, 2013 at 1:49 PM, Esther Hwang <ehwang827@gmail.com> wrote:
> Hi,
>
> I just installed the latest Git released a few days ago. I can't seem to get an application icon or find it on my Mac. I can only find the installer. Am I doing something wrong?
>
> I'm just beginning to learn Git.
>
> Thanks,
> Esther--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
