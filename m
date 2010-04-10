From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git rebase command and docs questions
Date: Sat, 10 Apr 2010 18:40:45 -0400
Message-ID: <p2s76c5b8581004101540h729564e8vc87fa269143b3633@mail.gmail.com>
References: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com>
	 <r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com>
	 <7vhbnk1gc6.fsf@alter.siamese.dyndns.org>
	 <l2nfabb9a1e1004091423te78b692btd8bbb03785f94a16@mail.gmail.com>
	 <s2l76c5b8581004101530h171f3c2dv6a2fc9d4225fbd4e@mail.gmail.com>
	 <j2kfabb9a1e1004101532tf16f9d55y404b5f7595d587c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:40:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jMC-0006Yu-OG
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab0DJWks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:40:48 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49733 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab0DJWkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:40:47 -0400
Received: by bwz19 with SMTP id 19so88025bwz.21
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=Tdv3QynhVYZC95W4+7dL/bjdQb1lyxmdK9/PyfpDn0Y=;
        b=k4PWNz60Cjs8PwR/sGTcqAMd1AQFyVimNvBGZBtK1z5aq6sqhaVciUwaxtwQsskkGO
         ZuuYCEbaXSEv5bQYxAMOPuI1Lp9vTGqljPCGYgoygaaEZJNVLQ2QWgkEuT2cCjq83V9d
         C+7zvEqivRA8S4fW+7+fA2K/2tlP35Kg8qzso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ukBocUZRSztJOL/8oRs3hQLaYdUERHZLXwAZBnmRGU69X+ss4LO1kLy2tr7H38XpCo
         BYhiDwWy7QIuipWSmDBWoHjtmynnYzRKorrHRV5QZACrqKEEIViqPEqVICEQNKgWjdWA
         3DzEbygVF7pUu2A9t1b+QAYG+WNhvPy2CXQ+0=
Received: by 10.204.97.202 with HTTP; Sat, 10 Apr 2010 15:40:45 -0700 (PDT)
In-Reply-To: <j2kfabb9a1e1004101532tf16f9d55y404b5f7595d587c3@mail.gmail.com>
Received: by 10.204.34.201 with SMTP id m9mr2161193bkd.127.1270939245689; Sat, 
	10 Apr 2010 15:40:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144610>

On Sat, Apr 10, 2010 at 6:32 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sun, Apr 11, 2010 at 00:30, Eugene Sajine <euguess@gmail.com> wrote:
>> How is that possible that it is not an argument to --onto???
>
> What I meant is that it's not "--onto=<value>", "--onto" is a boolean flag.
>
> --
> Cheers,
>
> Sverre Rabbelier
>

Oh, OK. I didn't know that - your paragraph makes sense to me now;)
Thanks!

Still all three questions from original mail are open...

Thanks,
Eugene
