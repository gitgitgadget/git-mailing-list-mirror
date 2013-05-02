From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/9] A natural solution to the @ -> HEAD problem
Date: Thu, 2 May 2013 22:48:58 +0530
Message-ID: <CALkWK0=osd8jQYfHcwO8=C_sMNgPj59Th=+tpfZfp7FeopMDyg@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 19:20:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxBK-0007dc-CG
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760958Ab3EBRTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:19:48 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:60253 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760919Ab3EBRTq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:19:46 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so944231iec.34
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xWEGM1ELpJRKTQNVsr6S0SXO08y6TVYJML1LLqpM/X0=;
        b=Fk8AMAFhiNsHfpRKDBd2olFTOjI9nyAGO+rdWiO0WRjrDDFYeX3rlorqmelr6c/FwG
         T1xMMPAW4qnJ+sk/Ccn9ftLs4/XTddZZTebgefeK1SSO4E7bHaNbGHxLgEOQcHayiRmj
         gjaRk3FSdKxjKGlUPwnr+UIU+mL2kX6ERsbiykZ2UqxyoQAAQ+zlelzmlzQiZR0fUBE/
         grEf2FpNiG7UTPonuG2WlNulN7z63VjD6tgs2SnKQY0V4xE5SLF1yWU1UmyAZOhJDwEa
         UsUhXzkbNT9Rcc9ucHdOC2z7LYBJdmtLxGQTQ3+iybUehnWjmihcVCvvLadEkR6FLF69
         iS2A==
X-Received: by 10.43.125.199 with SMTP id gt7mr3504335icc.48.1367515184955;
 Thu, 02 May 2013 10:19:44 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 10:18:58 -0700 (PDT)
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223229>

Ramkumar Ramachandra wrote:
> Felipe Contreras (3):
>   t1508 (at-combinations): simplify setup
>   t1508 (at-combinations): test branches separately
>   t1508 (at-combinations): improve nonsense()
>
> Ramkumar Ramachandra (6):
>   t1508 (at-combinations): increase coverage
>   t1508 (at-combinations): document @{N} versus HEAD@{N}
>   t1508 (at-combinations): test with symbolic refs

Can we just okay these six now, and drop the rest?

Thanks.
