From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [IGNORE] Implement 'git rebase' in ruby
Date: Tue, 11 Jun 2013 10:28:32 +0200
Message-ID: <CAHVLzckW=_HrRpzhE8+pAmDaKvXctxgBsRF7gQkM6rcp+ETU7w@mail.gmail.com>
References: <1370841722-8059-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=am0kDZWKuvdx9ph+zwtXdjRAbwu3e=GfEYUp+o8oy0g@mail.gmail.com>
 <CAMP44s2CqhxjzmZc7CiYER=F9BK1bxyCGBwCpLeq+yjDHwSj-w@mail.gmail.com>
 <CALkWK0ndiaAFaLxKd5=a_E-Cb0UebmxiBx3SryPGeT2U2nWKxg@mail.gmail.com> <CAMP44s2J5uD_E4qWecBaX8xYt=7MUn2muRykZ3Ac1ch_L319Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 10:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmJxK-0003BG-IL
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 10:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab3FKI3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 04:29:08 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34587 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3FKI2x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 04:28:53 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so10297911ieb.24
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4Y66Kr010o8DCsqj3Ttv015wGERk9cX7A4WzgodNaxY=;
        b=Z/Q7Co+BZuPjNg1xRMbPKS/dgkP/2NcLablR5xaOzr7ANLvc+i9djqZwWd59/WdFXp
         GIsTYtcdWE3tACcsa5pC/0unjuwasZtszJJLcG3a3U6ra8Fp3J1owtY0M2dgJi6xp2Ro
         Qc9PjyaswWrPW3q22HhluF6WWVEs/4YEfeMGDk/uhgexUOir//t5AZpkcNDUHuWBSLDG
         fT97DqLKk8yAbrxDEHmmqhBTUTVNSDrv53FZnf4flvSytaQOXZcy3IiTR9okbaknyq56
         cy78gvIe9WVNw3fNmKKA7YwKBDvqhWkuW5LKdJF4wZ8Q9Ciz7/wsICLY2muUiwByoeq8
         3IlQ==
X-Received: by 10.50.67.108 with SMTP id m12mr372050igt.66.1370939332141; Tue,
 11 Jun 2013 01:28:52 -0700 (PDT)
Received: by 10.43.98.9 with HTTP; Tue, 11 Jun 2013 01:28:32 -0700 (PDT)
In-Reply-To: <CAMP44s2J5uD_E4qWecBaX8xYt=7MUn2muRykZ3Ac1ch_L319Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227423>

On Mon, Jun 10, 2013 at 11:47 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> This is not my first patch that gets rejected, but it's the first one
> that gets rejected by Junio without even looking at it. What is
> anybody supposed to think about that?

My very humble opinion: submit again the series without including in
the cover letter "This patch will not be applied"
and then handle the feedbacks.

In short, everybody should simply approach again your work with a "fresh mind".

regards,
--
Paolo
