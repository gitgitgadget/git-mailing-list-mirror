From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Merge after directory rename ?
Date: Tue, 23 Aug 2011 14:50:33 +0000
Message-ID: <CAMOZ1BtY=-F555pKtNWbNgRt_T-V5mtQE9dxTk-MQzhgNBuQXw@mail.gmail.com>
References: <j2ru2h$cd$1@dough.gmane.org> <CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
 <CAMOZ1Bt8cP146xiDXfSA-naSOaS3AC8pUZgW12=3TMg2JGCD=w@mail.gmail.com>
 <j2s83l$eqg$1@dough.gmane.org> <CAMOZ1Bsb7UxYOFpRWh47+130upfD9_E=CMQtZd1NyUWPwWiW4A@mail.gmail.com>
 <CAC9GOO8w_zZ8wuRambnGoaS+rKskdjuSZVpF+b4mzdhzK48bjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 16:51:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvsJr-00028f-9J
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 16:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab1HWOvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 10:51:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60738 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1HWOvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 10:51:04 -0400
Received: by gwaa12 with SMTP id a12so143405gwa.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PAQUMmZIPWvg+4BiGufHxNikxJUt0n56/eVaOjdKBOM=;
        b=V5Mg53WHSB4V4XTzlJwhnnEgfLVgE+f/ynMS6k3wcQz4u2JHXjkSPEKFKhqAWs2Soi
         724VM5xRSdMra2btRbqLz0qdsXyOPCmOzB1NCGbiqiE9xDWyI4IvNxZMYolShRx1TNJP
         Gj9ObR8t4l3Uc3IpOAgvMh17hlli+8lSE8dTU=
Received: by 10.43.52.1 with SMTP id vk1mr3688598icb.129.1314111063163; Tue,
 23 Aug 2011 07:51:03 -0700 (PDT)
Received: by 10.42.138.66 with HTTP; Tue, 23 Aug 2011 07:50:33 -0700 (PDT)
In-Reply-To: <CAC9GOO8w_zZ8wuRambnGoaS+rKskdjuSZVpF+b4mzdhzK48bjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179939>

2011/8/22 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
> Well kind of. Your example was different because you have created dir=
1
> independently on branch1 and master in which case automatic rename
> wouldn't be expected. If you would've created dir1 before branching
> and renamed dir1 to dir3 (renamed all files under dir1) then I would
> expect a rename while merging.

I already covered this case in my initial paragraph. Good Luck!
