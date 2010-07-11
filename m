From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: command return values
Date: Sat, 10 Jul 2010 23:18:55 -0500
Message-ID: <AANLkTilJigJ1YjRrZBwLyfpF4iTFCI8wKzANpL3yf00D@mail.gmail.com>
References: <AANLkTimQcqhD8FClAXef5dGAWRDbAGdVBmIVXxotzKoa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Brian Craft <bcboy@thecraftstudio.com>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 11 06:19:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXo0k-0003fl-EK
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 06:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809Ab0GKETQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 00:19:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52780 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab0GKETQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 00:19:16 -0400
Received: by gwj18 with SMTP id 18so1641160gwj.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 21:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=TttYd8bfUvyV6Eaetka8QMpw8TgYPgJ+1jtdcQQt7wk=;
        b=KxnjN0sxi0bidDynemjRuNr11cnfGFIE43TOLv5xTVfisn1DDRU9t12yhh/Osfcrhr
         Oh+QegwdqDt5055aLzRyHUMxWDDJUsG3N18gyataZMPgX6WxUcFm8zVKTjp79TM4+qUg
         amzhTX8yU/ffE0lSeayogAr52dEjf/QS+qZQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ooDxhRdORaEp5i0wEs8qAyZqiTv6vI2bOafYjNtAyraUYzK9QJHqbeqQ2NQxTx3Oax
         AhC96i5GyopsC392FYZlsKdCIougUinHjpZ/LWPusajDfPbapi6drZFTDjIXhBKrsGG3
         VZssLH/ooN6ZIMRawLa6NmIlqibuydJF7zblY=
Received: by 10.150.164.17 with SMTP id m17mr3595217ybe.272.1278821955244; 
	Sat, 10 Jul 2010 21:19:15 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Sat, 10 Jul 2010 21:18:55 -0700 (PDT)
In-Reply-To: <AANLkTimQcqhD8FClAXef5dGAWRDbAGdVBmIVXxotzKoa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150741>

Heya,

On Sat, Jul 10, 2010 at 23:11, Brian Craft <bcboy@thecraftstudio.com> wrote:
> btw, the "faq" link on http://git-scm.com/ is broken.

It seems that the git wiki is down?

-- 
Cheers,

Sverre Rabbelier
