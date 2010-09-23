From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Listing files in order they are changed
Date: Thu, 23 Sep 2010 22:53:07 +0200
Message-ID: <AANLkTi=_GOBuha0cw=qbUTXyUMdiLANPZXoPSOs_rKT8@mail.gmail.com>
References: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com> <m3pqw4gpb2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Parag Kalra <paragkalra@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OysnZ-0000He-Kq
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab0IWUx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 16:53:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53639 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756647Ab0IWUx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 16:53:28 -0400
Received: by gwj17 with SMTP id 17so737884gwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=yUQbc7H5Bs+qJKFlW7jyr9Y1cxyX/g6lgNPTpJ2a6j0=;
        b=dAsh4WIu7bO/km7HE9cCQJ/AdHlN4WyuEDUuqvdENa84POjS4rogR1XAwxNjeD5piD
         Q5H1Qus1G6sA1VJfp3/nV8yxOENltUWuxtpgGmB49sBsOZCOs9zZz0+Kd4/7qdAvbqqe
         05H5K+EtviK9WXrr63j/fX2vEu9zdqoRTMFrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uFVkW9LXu2GDkUyyDRIhq2ZJa/P6LoWqQqTsK6ctbMKlY+dAg+X99GBppkr3oVxcyn
         SepPAUpf/KC6qEYj/8Q2cNotTZmm5XzVlsQ/uh9TF2HdnSnnMfMF4jO2vjAzC4IOtnWf
         F/0TLxyh0BrHTrr7zxfJV1KI9wT20U9EAqSTU=
Received: by 10.150.136.4 with SMTP id j4mr3548491ybd.293.1285275207340; Thu,
 23 Sep 2010 13:53:27 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Thu, 23 Sep 2010 13:53:07 -0700 (PDT)
In-Reply-To: <m3pqw4gpb2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156909>

Heya,

On Thu, Sep 23, 2010 at 22:48, Jakub Narebski <jnareb@gmail.com> wrote:
> The tree blame ("git blame <directory>"), if it existed (I have
> working prototype), would be of use here.

Ok, I'll bite. Won't you please show us your tree blame prototype Jakub? :P

-- 
Cheers,

Sverre Rabbelier
