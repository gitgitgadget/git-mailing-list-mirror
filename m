From: Nikolai Weibull <now@bitwi.se>
Subject: Re: Command-line options that lack documentation
Date: Thu, 21 Jul 2011 23:09:18 +0200
Message-ID: <CADdV=Ms6vK0vLV4sy-bGmD7raTKtEMCK_R4UqhyKNz8Q4T05Ug@mail.gmail.com>
References: <CADdV=MsNyhOg7r9NV67e0V1_7FCvdBu4YA=7gAEjPLagP0r9yw@mail.gmail.com>
	<4E288993.3030005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 21 23:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk0Un-0001lZ-1g
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 23:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab1GUVJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 17:09:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45918 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab1GUVJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 17:09:19 -0400
Received: by pzk37 with SMTP id 37so2478336pzk.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PUJYD/6gU/7OtowDHU1d0J7HScGbcSlg7w1/ocdygLk=;
        b=NtLnREQqKtO87PFN4svMvHbNVyAgE7XxJL4IIbs+vXvvENJ0e8rDHyzD7g/DeDyoqa
         dLeLTYt0vIOZLIjyGlHaR+s8rUanYXZE1JHnvMNLdqnqBTJHUw6WEe64lazh8HzehNNe
         FoS/zVQaoH9IXTHnwCR+pktIHbikmcezvipKc=
Received: by 10.68.31.1 with SMTP id w1mr1045506pbh.421.1311282558719; Thu, 21
 Jul 2011 14:09:18 -0700 (PDT)
Received: by 10.68.48.200 with HTTP; Thu, 21 Jul 2011 14:09:18 -0700 (PDT)
In-Reply-To: <4E288993.3030005@web.de>
X-Google-Sender-Auth: uOaiQLuZCXrMJ5mhax7CTZS8ZK4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177624>

On Thu, Jul 21, 2011 at 22:18, Jens Lehmann <Jens.Lehmann@web.de> wrote=
:
> Am 21.07.2011 14:07, schrieb Nikolai Weibull:

>> The following options lack (full) documentation in the manual pages:

>> git-submodule update:
>> =C2=A0 --init

> "--init" is documented in the synopsis and under the "init" and "upda=
te"
> commands.

While that=E2=80=99s true, It=E2=80=99s not documented under the OPTION=
S header.
