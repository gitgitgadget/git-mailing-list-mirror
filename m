From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v4 2/7] i18n: rebase: mark strings for translation
Date: Wed, 25 Jul 2012 15:32:14 +0800
Message-ID: <CANYiYbHnv0JppT64cnjzBgRq7_pRFHN5WMy2SAVj2GzG+dWBaA@mail.gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
	<915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
	<20120725042134.GA3055@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 09:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stw50-0004NM-R5
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 09:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab2GYHcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 03:32:16 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:54355 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2GYHcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 03:32:15 -0400
Received: by ghrr11 with SMTP id r11so406181ghr.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PMtQBmDzRdp194Yl11HLDOZTAP7X1nQCnqrmtNb/hgI=;
        b=M/o7N7pcH7n0QFWUqOWnCkNX4QgZR4Kpp6kEkKZqhGph8vBJy3Xxv9eNhQ/CUHliYi
         lp1faacJpfZWgb+/oDZ0zUHFLJFZBkkwFRhmYuGWhTsr3RH2TMm1XW2QXZJ2U+rT/nrI
         vx1BEIHS6cGKzSHsO06xnS55WtxxWUPlwCu8vY9fOBM+jRxCK2lFC83BuMzlMEqBqr40
         IZAc9ZwdBFUMGh9gwpEvst4+985gOAblxyyDZP/3L1a3wKe5L0WGbZTZgAZbc2DCgl5Y
         U20/WkOpxL7G9JSplosBd2lSqFKWUSIxxfi9pY4gLvOx7Zd0klc9DtxLr6IBxyjI72ht
         bNVg==
Received: by 10.43.124.201 with SMTP id gp9mr22305905icc.47.1343201534708;
 Wed, 25 Jul 2012 00:32:14 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Wed, 25 Jul 2012 00:32:14 -0700 (PDT)
In-Reply-To: <20120725042134.GA3055@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202134>

2012/7/25 Jonathan Nieder <jrnieder@gmail.com>:
> I haven't tested or reviewed this patch in detail, so even though it
> looks good, I'd prefer it not to have my Reviewed-by.  (See
> Documentation/SubmittingPatches: '"Reviewed-by:", unlike the other
> extra tags, can only be offered by the reviewer'.)  If you'd like to
> credit my help, something like "With advice from Jonathan." would be
> fine.

How about Acked-by: ?

-- 
Jiang Xin
