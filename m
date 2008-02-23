From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: How change e-mail to use google's gmail instead of machine's prompt?
Date: Sun, 24 Feb 2008 00:08:20 +0100
Message-ID: <998d0e4a0802231508h422ca60crd3fc6e3c43cdd2eb@mail.gmail.com>
References: <998d0e4a0802231444t1632ed97r102cefdfe4d3990d@mail.gmail.com>
	 <m363wfcm3v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3UL-0007Wv-MC
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbYBWXIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYBWXIZ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:08:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:19170 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbYBWXIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:08:24 -0500
Received: by wx-out-0506.google.com with SMTP id h31so860260wxd.4
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 15:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=v52+uQPXDocZZEhRaoD8k/dHS9WkWulOtRQUcQgia5k=;
        b=nsF136iYiszm0lX2Ush/Tvy3qnQtcSf68cjZCjFXtEXWn4Cl1FTWF4MXCf7gImC1qcV4EKLzPYus9za/WRoEkTM6tkrpBde++KayNgT/WAiVsrhrNAh3i5mSaeC3K9FQJR7rGij7WUNXJEQbqOzrVUC1wmAnZGJRMIOSoMIojV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Az2+qMas458IfQwZkPm/u1wI6i/pApUfRC36AMLd/a1aDa4EENqf6ZNz9PE+jTKP7+hROL8YBL1THR8uxL/TCZaMa88puPYO/h0qjq5m0UKjSYvHWWu/HwRwuhVBYfujVkn4hr6JwEI/q0B6UYc6dnYU0uYz8eNotNJ8P+1E8+w=
Received: by 10.70.11.5 with SMTP id 5mr651793wxk.10.1203808100200;
        Sat, 23 Feb 2008 15:08:20 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Sat, 23 Feb 2008 15:08:20 -0800 (PST)
In-Reply-To: <m363wfcm3v.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74878>

2008/2/24, Jakub Narebski <jnareb@gmail.com>:
> "J.C. Pizarro" <jcpiza@gmail.com> writes:
>
>  > Hello, my short prompt in the console of my machine is
>  > +---------------------------+
>  > | net1@pc0:~$               |
>  > +---------------------------+
>
>
> > How can change it to use my own email jcpiza@gmail.com instead of my
>  > machine?
>
>
> RTFM!!!
>
>  Edit your .gitconfig file in your home directory, adding
>
>  [user]
>         name  = J.C. Pizarro
>         email = jcpiza@gmail.com
>
>  or, if you prefer to use CLI utils:
>  $ git config --global user.email jcpiza@gmail.com
>
>
>  >  I loved the old Internet but i hate the new Internet services-based when
>  >  Internet is controlled by companies and governments for that you can't do
>  >  anything because it's controlled by them instead of by your.
>  >
>  >    #;)
>
>
> WTF?
>
>
>  --
>  Jakub Narebski
>  Poland
>  ShadeHawk on #git
>

Very thanks!
