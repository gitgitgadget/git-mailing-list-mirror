From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [IGNORE] Implement 'git rebase' in ruby
Date: Mon, 10 Jun 2013 16:47:15 -0500
Message-ID: <CAMP44s2J5uD_E4qWecBaX8xYt=7MUn2muRykZ3Ac1ch_L319Sg@mail.gmail.com>
References: <1370841722-8059-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=am0kDZWKuvdx9ph+zwtXdjRAbwu3e=GfEYUp+o8oy0g@mail.gmail.com>
	<CAMP44s2CqhxjzmZc7CiYER=F9BK1bxyCGBwCpLeq+yjDHwSj-w@mail.gmail.com>
	<CALkWK0ndiaAFaLxKd5=a_E-Cb0UebmxiBx3SryPGeT2U2nWKxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:47:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9vt-0008C8-LF
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab3FJVrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:47:18 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:63745 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602Ab3FJVrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:47:17 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so2596325lbi.6
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=edrsfRlrAVqn3EW5ziBPv44RhV3cYO+1ua30Ferh2Ws=;
        b=WBn9AH7mepbtKS4aGP6DyXjJYlKlsKqqqeuaNHBFE0Qvj1xceqyj7Fa5ZD/cJ0TwCV
         xX+kFHwx0jIwhuc6jyoiEvndz4xM+PsZNuxEI5olUExCrYUPikjzAmSXGs6QJ9pSSsRx
         P8Qney9KTMzUIduFVzRDI99XDcP7eLuZhMXZO6xRBfgS4O5ykWxz3jXE0/u0C+U/9FQ4
         t1NbcIrVJqtYQyw9InZoE68+TeJYV77e1U+KrLVcuvoKewrOnrSWOkAF/ESkqFv4SP9W
         fsTRd0WoUcDAqEkx2m01ebW3u/GkEsJMmA6Kvy0RG4m11MjucDxYyZEaGfMk5lP+1l6D
         FPYQ==
X-Received: by 10.112.157.226 with SMTP id wp2mr7329157lbb.65.1370900835496;
 Mon, 10 Jun 2013 14:47:15 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 14:47:15 -0700 (PDT)
In-Reply-To: <CALkWK0ndiaAFaLxKd5=a_E-Cb0UebmxiBx3SryPGeT2U2nWKxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227392>

On Mon, Jun 10, 2013 at 3:07 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> I think that's the only way forward, since the Git project doesn't
>> wish to be improved.
>>
>> Perhaps it's time for me to create a pseudonym, and when you have to
>> do that to land clearly good patches, you know something is *REALLY*
>> wrong with the project.
>
> I ask only for your patience, Felipe.

How much time? A day? A week? A month? Not even a year would make my
patches to 'git cherry-pick' and 'git rebase' be magically applied.

This is not my first patch that gets rejected, but it's the first one
that gets rejected by Junio without even looking at it. What is
anybody supposed to think about that?

-- 
Felipe Contreras
