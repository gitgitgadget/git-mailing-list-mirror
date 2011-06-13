From: Michael Witten <mfwitten@gmail.com>
Subject: Re: file mode
Date: Mon, 13 Jun 2011 13:58:17 +0000
Message-ID: <BANLkTikZZsuQ9PoNvMOoRCg=kAnwQOvOSQ@mail.gmail.com>
References: <alpine.DEB.1.10.1106122055210.6124@localhost> <BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com>
 <20110613053814.GA2680@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Kleiweg <pkleiweg@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 15:58:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW7fJ-0002DI-0N
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 15:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab1FMN6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 09:58:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab1FMN6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 09:58:47 -0400
Received: by iyb14 with SMTP id 14so3823282iyb.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=P2P8uMXtogs+8kgk2rLdt9Oj6FGekUgDZJISQliC6bk=;
        b=Jf2HhnLwOcMgJKLOHvi43Tj57iAlwMc1ZyWxsqi1DnyDxVMxSWyrwX9OVq3E1MvTbM
         9y4aIFxqIn9fjLpBFC8NotprSHQMtnthRuVkuV9acB26hqTJ9vS46kjH+QZCyQowi4oW
         mf2lZ8yxA1pKJdfsGeBDzZdpgxhyhFpmkChmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=w8DWZ3ZN/JvsRBoaWlUb7HBd62a3eenmvpwrmXgoqXXR2lLjwRV4lhq2N4XeSPyEBr
         T/v/18ci7r9t6aVFsa1t/TYUkbMwPkBeBYu0t6SjO5lrjK4BbYKT7zN3284yJQyUsrKV
         KdFrv5GYPOEt976bHE/09oCXIw5QxLenOx/KI=
Received: by 10.42.174.69 with SMTP id u5mr5162369icz.381.1307973527102; Mon,
 13 Jun 2011 06:58:47 -0700 (PDT)
Received: by 10.42.217.197 with HTTP; Mon, 13 Jun 2011 06:58:17 -0700 (PDT)
In-Reply-To: <20110613053814.GA2680@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175705>

On Mon, Jun 13, 2011 at 05:38, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 12, 2011 at 07:12:42PM +0000, Michael Witten wrote:
>
>> On Sun, Jun 12, 2011 at 18:57, Peter Kleiweg <pkleiweg@xs4all.nl> wrote:
>> > I added a file that has file mode 600. When I do a check-out,
>> > the file comes with mode 644. Is this supposed to happen? Then
>> > how do I control what permissions files have?
>>
>> Do some googling.
>
> I really don't see the point of a response like this. It is one thing to
> rudely point somebody to lmgtfy or an FAQ link. Then you're still being
> rude, but at least you are pointing them in the right direction. But
> this seems simply to make the list a less pleasant place _and_ to be
> totally useless to the original poster. If you didn't want to give the
> answer, wouldn't it have been better not to respond at all?

No.

Firstly: My response shows that there are abundant answers, which is a
nicer answer to receive than no answer at all.

Secondly: I didn't see the point in RE-WRITING all that has been said
on the subject before, and I couldn't be sure that somebody else would
be willing to do the same too (I figured it was a good idea to supply
at least one response).

Thirdly: Seriously, at least do some googling first.
