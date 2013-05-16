From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] color: set color.ui to auto by default
Date: Thu, 16 May 2013 19:07:14 +0530
Message-ID: <CALkWK0msyYGo0NSkwvGJA7uy4tNvE+gZmaZ_Qguwm_aq60NpXg@mail.gmail.com>
References: <1368709468-18610-1-git-send-email-artagnon@gmail.com> <vpqfvxn12gv.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 16 15:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcyNb-0002q8-QC
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab3EPNhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:37:55 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47525 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab3EPNhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:37:55 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so6534672ieb.10
        for <git@vger.kernel.org>; Thu, 16 May 2013 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=A/6BgKHXWguLAsO2UU9Kqocxlc6JeYvCvSBleJ7GA60=;
        b=k5TwwvIX8lKwqAPxGivEQYrrF5kppsyADPmdIoSau22nojwgAwbCWRP5yiWxt+WHiw
         CqTDHM8d1NgF7GFizkD2qq6TxNg0StQgNWtTh/Y4Ko+1mY7vfb/cVWcn/aVCXSLsK1x2
         fZwBi78RKgyCJeQ3YMTkY978jZhTEuoDENvas8Vr64ivyopJhrxskonGr+PhbP8XeOOz
         AZpJ/C9ig9vv6QHnzFwKO3fNsBcJ9SDCBV8bnXhi0GiceAlClFpBKlBaqARbNAxsp/7m
         2ZG37nJfftQq/pXSfYAGzRIduYYRjwF4PJ21Tg6BogtNtcAvKur1/Jm7+rFD9lMz6ou0
         jyow==
X-Received: by 10.50.33.19 with SMTP id n19mr9343632igi.44.1368711474958; Thu,
 16 May 2013 06:37:54 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 06:37:14 -0700 (PDT)
In-Reply-To: <vpqfvxn12gv.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224567>

Matthieu Moy wrote:
> Err, you're comming a bit late ;-). See my patch, posted yesterday, for
> the same topic.

Ah, too much email :|

Your patch looks good.
