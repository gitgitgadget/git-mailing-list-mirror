From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: --mixed option is deprecated with paths
Date: Sat, 14 Aug 2010 18:55:31 +0000
Message-ID: <AANLkTimT7jTQeN1qUBSWTwEEt9jWirwwS3bSHT7OysUs@mail.gmail.com>
References: <AANLkTik_NuG3YKMknwh4fAK09kTH0tK1f08MzsexUMcV@mail.gmail.com>
	<i46nvf$fa$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ralf Ebert <info@ralfebert.de>
X-From: git-owner@vger.kernel.org Sat Aug 14 20:55:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkLtS-0005WA-Id
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 20:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab0HNSzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 14:55:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33173 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910Ab0HNSzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 14:55:32 -0400
Received: by yxg6 with SMTP id 6so1469797yxg.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R1b5BH44L1roR0EO5OSEfYCPKs8c+lKjzjWHlwoCGsw=;
        b=dgh1piqCHRE91h16oKt+jJX3ZZYea+rDOE31mSwZJldrfTH0JLRueFZog1B20fTCzi
         RwFle9d5jrAgTHk2W7QLapwcDShG/PCjTGNKfCRFiUyTH8pZSGnIBONGvMMMg5D9cRry
         KxdO2F3125SKlkiwCJT8KE7sKLjDj08LweNic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HwKYM589KDCO66+eu4ILuD2lk+SCJl9NPQd8a4kjqHnH0lxT6o86sVLs6fnwmk6hzl
         GGJqRVNCNVgl7pE5Ybthxxqj5bF3JMnUuDmZEbpskwsHapG32cvx0ef68QPoqAp5rH+U
         XxCefg64jMmuLGaCQReiByH/9d7UMB51Q8XLs=
Received: by 10.231.12.75 with SMTP id w11mr3366051ibw.134.1281812131544; Sat,
 14 Aug 2010 11:55:31 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 11:55:31 -0700 (PDT)
In-Reply-To: <i46nvf$fa$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153571>

On Sat, Aug 14, 2010 at 18:40, Ralf Ebert <info@ralfebert.de> wrote:
> On 14.08.2010 17:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> So what should I use instead? 0e5a7faa which introduced it doesn't s=
ay.
>
> It doesn't currently exist, but I'm pretty sure it should be called '=
git
> unstage' :)

Then perhaps it should be undeprecated? If what you say is correct
it's been whining about that since 2007 with no alternative, while
doing what I mean when I run it.
