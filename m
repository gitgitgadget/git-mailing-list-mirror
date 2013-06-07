From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Sat, 8 Jun 2013 00:31:08 +0530
Message-ID: <CALkWK0nD4xudS=XG1z+KRxnUmOA6sG6NpRX-rZc1CjNodzcGAg@mail.gmail.com>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org> <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com> <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1v7-0007yQ-BD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab3FGTBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:01:49 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50833 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094Ab3FGTBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:01:48 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so11710844iej.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ePBpnxl+so/QuqNlDqy0D6bb2uj7rR9I1QsQSjVDQXI=;
        b=RarN30kOcsObwU37heQD5q3BfjeCRYSRV7PyaJ7T/eVfdGcabPyWh4YdV/bcYde53T
         wJYp7rUcR/609i9v/uOOrJiKwdV0YJGRdmBO3ff7MHKjCfCKTNLigfZLA+7ckgBb6zW6
         J+RXnp2mYrShY+bUU9AGPBm/xsetw/sDJFSkX5O4zYQnNviIp5rtXpdHOM3dnAIo8D5H
         wHPV5eo5mEfR/7Ako6tm3PxAKZhUZ90HBYQClEbDTw8/DSf2n/T0ZLogjuUPEjE6VwVx
         ljfZH6y17j2N28VfiY2Bwf0pUntB9KNc6lQPf8XxZ06r8a+r+docnmzJCSwchxg3xlz7
         DCuA==
X-Received: by 10.42.31.69 with SMTP id y5mr19524523icc.44.1370631708350; Fri,
 07 Jun 2013 12:01:48 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 12:01:08 -0700 (PDT)
In-Reply-To: <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226672>

Junio C Hamano wrote:
> "git log -Gcomplete_file -p contrib/completion" found this one:
>
> Now I do not recall suggesting it, and you (and I today after 2
> years) may disagree with the rationale, but at least we can read
> what was the "intended" meaning, I think.

Having spent so much time documenting pickaxe, I should atleast learn
to use it more often :\
