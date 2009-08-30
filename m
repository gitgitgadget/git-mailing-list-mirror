From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Anyone meet DNS fail translate repo.or.cz
Date: Sun, 30 Aug 2009 18:58:54 +0200
Message-ID: <237967ef0908300958y177e4274q13c830ce7bec0569@mail.gmail.com>
References: <1976ea660908292120r7e7ec941he7573671251451f5@mail.gmail.com>
	 <40aa078e0908300339j74e9c542x3436ec2e58e4b874@mail.gmail.com>
	 <237967ef0908300350k4e06b522x9baa7aa5528d32d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 18:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhnkj-0000uR-KD
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 18:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbZH3Q6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 12:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753780AbZH3Q6y
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 12:58:54 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:35037 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbZH3Q6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 12:58:53 -0400
Received: by fxm17 with SMTP id 17so2378715fxm.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=UfbEZtQySnW6oP9EV5HqFWS0b8GiyVWisiZN0jRTTxo=;
        b=GLigopkO47Tlc16A42z19MxRFilRX8y+32Q7HcqpDB6929HdEp11aX+Osqq/IY9FFc
         0xmmNdua7gCbTRySbWHkFQyYJMxiGp/nCGRFeVoSMrhe+sdj0AZj7VYneZ56uCDr6Ume
         /+KORYyxdKXJHqtuDaOTQzt1FzylY2FUfV6zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Byi3XF55hirD+QsC7B5vcV7vpqAWjokhENs7Fh763pZe+3jx6FSK/19AX7M5/SKB+l
         l6SeUVpVxKIKXBdkdIUd/iYedPa250SSN190cTB1Z+fyHO4fjxPwtSWh/VLWmQafHo++
         zcWCEQWJJXpz4IRDl+L/Q93m/+hVi/bbcppDQ=
Received: by 10.204.154.209 with SMTP id p17mr3391295bkw.104.1251651534858; 
	Sun, 30 Aug 2009 09:58:54 -0700 (PDT)
In-Reply-To: <237967ef0908300350k4e06b522x9baa7aa5528d32d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127416>

Seems to be back up now.

2009/8/30 Mikael Magnusson <mikachu@gmail.com>:
> 2009/8/30 Erik Faye-Lund <kusmabite@googlemail.com>:
>> On Sun, Aug 30, 2009 at 6:20 AM, Frank Li<lznuaa@gmail.com> wrote:
>>> ALL:
>>>       I can't access repo.or.cz from yesterday.
>>>       DNS can't translate repo.or.cz.
>>>       Even
>>>       http://www.dnswatch.info/dns/dnslookup?la=en&host=repo.or.cz&type=A
>>>
>>>       It also can't recognize repo.or.cz.
>>>
>>>       Anyone meet the same problem?
>>
>> Yeah, I've been seeing the same problem here.
>
> The IP for both repo.or.cz and git.or.cz is 62.24.64.27
> If you add this to /etc/hosts you can still access both fine.
> 62.24.64.27             repo.or.cz git.or.cz
>
> --
> Mikael Magnusson
>



-- 
Mikael Magnusson
