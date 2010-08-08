From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Re: [PATCH/RFC] tests: WIP Infrastructure for Git smoke testing
Date: Sun, 8 Aug 2010 14:54:21 +0000
Message-ID: <AANLkTimdFz38gfq1oW0VQ9giaavFnqRUH8DDEeoFN=BT@mail.gmail.com>
References: <1280438455-16255-1-git-send-email-avarab@gmail.com>
	<201007300011.50330.trast@student.ethz.ch>
	<20100808134238.GA9659@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Aug 08 16:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi7Ge-0006yu-HA
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 16:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab0HHOyX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 10:54:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57333 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0HHOyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 10:54:23 -0400
Received: by yxg6 with SMTP id 6so3216723yxg.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KNFxbAYCNFn2cxUYOhUyVxauzbH4oPqu5AtcLZubX7A=;
        b=dwtBlJ+bRSA+HSPQbXrouDAbElvOSVPTFC0k3b34HGfx16ds+JSMSEUOs3Ww7/TZ00
         Uwx0qgHScVDQVbFuQidIajHliqkKaLhXC8hGLnLNFqGgVhttBZYzIPH1JxS1Ccmq+L3s
         4J+sRK7HGAOFVWQVRhgkAvciTetU3pt+bFtIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PM1kjjjYpM+yV4OXH9PquwB9EWYaRDUkcmksipg5Knr2dhVo4aKqp5RC6KQlSpCZgt
         2LqVc1tDk7xUWUGiRX5a/WNV4Xplnk1ss5gm1qclrBmSq9HXoCXNf+LA4GUDBldjOrFM
         KvKdqY3tOho3uEsPE5yLSQvJtSkR+6Zd0KYRc=
Received: by 10.100.127.15 with SMTP id z15mr16451078anc.213.1281279261991; 
	Sun, 08 Aug 2010 07:54:21 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 8 Aug 2010 07:54:21 -0700 (PDT)
In-Reply-To: <20100808134238.GA9659@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152916>

On Sun, Aug 8, 2010 at 13:42, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Fri, Jul 30, 2010 at 12:11:50AM +0200, Thomas Rast wrote:
>> =C4=86var Arnfj=C3=B6r=C4=91 Bjarmason wrote:
>> > =C2=A0 - Is this worthwhile. Are there developers / packagers / ot=
her
>> > =C2=A0 =C2=A0 interested parties here who'd be interested in actua=
lly running
>> > =C2=A0 =C2=A0 smoke testers? It should be really easy to set one u=
p.
>>
>> I'm all for it!
>
> Me too! I should be able to setup a cronjob for tests under a Windows=
 XP
> machine. Does that count as an obscure platform ? ;)

I think it does :)

I just sent another version of the series to the list. It'd be very
useful if you could try sending a smoke report from Windows XP.

Thanks.
