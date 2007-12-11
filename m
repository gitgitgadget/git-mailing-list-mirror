From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 19:20:00 +0100
Message-ID: <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: David <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29iV-00006C-Cm
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbXLKSUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbXLKSUE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:20:04 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:6158 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbXLKSUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 13:20:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2124223rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0c4YnSdURCkafUgsopUAkDtJl+IguqexhKU12+994ek=;
        b=nFv+XguKvVuw2E4CGNLxhfQrBpfGQmYhMzpzuRbpaX3YbkvaRGjCioUtLK1D9lCuW73VNzHqwoN21AD5wqYPm8f9ZCM1+684s6iTEE8diCaHC/wD0vWRbbnX5tuwGW3JbKAux32fmTHH4/+f5ajdg1Vx3Q5pYKM8HaH2onwS6Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HSHX7vVeW3TO0tZ9KMnL8iaI9LxBhpB8kuPFy5FEsG0TtDa19HzWNPe58oGF0uAV1+bQqeCKRfpB3yv3OB+ybJOZXf1RWsVQjyVkxXo1wuiAjso0unahZRl9fneMZUknl8IJoSpKJ0bd2qt6rb/eOoHxZEcMU7pcTO4o62IoQ7o=
Received: by 10.141.20.7 with SMTP id x7mr5200281rvi.1197397201007;
        Tue, 11 Dec 2007 10:20:01 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 11 Dec 2007 10:20:00 -0800 (PST)
In-Reply-To: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67898>

On Dec 11, 2007 2:48 PM, David <davvid@gmail.com> wrote:
>
> Of course there are some notable things missing (such as proper i18n),
> but it's not too bad for a first draft.
>

Cannot start the thing...

$ python bin/ugit.py
Traceback (most recent call last):
  File "bin/ugit.py", line 6, in <module>
    from ugitlibs.models import GitModel
ImportError: No module named ugitlibs.models
$

Some hints?

Thanks
Marco
