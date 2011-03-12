From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Gitolite documentation mkd files??
Date: Sat, 12 Mar 2011 11:21:13 +0000
Message-ID: <AANLkTinu8kyQF20OALWZbUeQ0BO4Em3+ZUZgVa6OCsqM@mail.gmail.com>
References: <AANLkTimQOzw-TYPO9ue3D_a0J8toFQZR4GDgoc2n2iin@mail.gmail.com>
	<m3y64k61lt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 12:21:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyMt0-0007ki-4e
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 12:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab1CLLVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Mar 2011 06:21:14 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45506 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab1CLLVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Mar 2011 06:21:13 -0500
Received: by yia27 with SMTP id 27so1474912yia.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 03:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EWi99ieEJ1OE1xFyDh21PMUUGBJsWkfjE8oE+1em8o4=;
        b=YTf4N7EKLW0kYGEKFkPlqswPfaD9RXyiOlCOFuvkehgvoruGqNn3pS4nTtVLrpyK52
         ZXmRt9rTmUkGdSk/QuPpBFDMetKZRo7bnJJUMxV4ClvSzrqU42QvJyzFsGDpJuKHvnI2
         gD11T1hiSWZLl4kv7Z9MUc6bGMgMo/KMRoHhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cW3G3E4qwjdmpOXkrd4MnNh2aHRiYxrUO7Xk134tDN4F5HzPs3MFMZY7H9tgNInHmn
         fzKRsLKTHBupKyt1irPoczIL1+3SbfE68VTT64p4bqJubY/gqjY2CUGXYxkNMBQTbTKN
         YEMBw3wpjjHx01gbVK/RViB99nszdZwENKXjM=
Received: by 10.90.26.7 with SMTP id 7mr1041518agz.75.1299928873130; Sat, 12
 Mar 2011 03:21:13 -0800 (PST)
Received: by 10.90.94.9 with HTTP; Sat, 12 Mar 2011 03:21:13 -0800 (PST)
In-Reply-To: <m3y64k61lt.fsf@localhost.localdomain>
X-Google-Sender-Auth: uPwVPLz05RDqI57w1OiCFEokyxM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168941>

On 12 March 2011 11:05, Jakub Narebski <jnareb@gmail.com> wrote:
> Howard Miller <howard@e-learndesign.co.uk> writes:
>
>> I'm sorry if this is the wrong place to ask...
>>
>> What's the story with '.mkd' files in which the docs are written for
>> Gitolite? I would normally just check Google, but that doesn't seem =
to
>> have heard of them either. What is there that reads them properly?
>> It's only a minor inconvenience but I'm really just interested to
>> know.
>
> Those are files in Markdown[1] format, a lightweight document markup
> language. =A0GitHub renders it to HTML automatically. =A0It is suppos=
ed to
> be readable also in un-formatted form.
>

Oh right! I remember that. I didn't realise anybody still used it :) Th=
anks!

It is perfectly readable - I just wondered what it was.
