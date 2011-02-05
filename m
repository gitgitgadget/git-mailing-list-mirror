From: Valentin QUEQUET <valentin.quequet@gmail.com>
Subject: Re: GIT - cloning torvalds/linux-2.6.git repository trouble.
Date: Sat, 5 Feb 2011 19:08:32 +0000
Message-ID: <AANLkTikYPHhVaKYsQpZ2FhjxAdLetPgkPFQ-b-VtkBTJ@mail.gmail.com>
References: <AANLkTikiKagzJMh_xuOSzfA4c-qxOHhVeU2jhmbaDHji@mail.gmail.com>
	<AANLkTi=FAWh9T3HaocdKB7V4osRPsehTo=hTP0U-JbfR@mail.gmail.com>
	<AANLkTi=E3gWG2-3nLBW6JP+Wks2=4oUWSNSpk0=qEaU-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 20:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlnUs-0003aA-RS
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 20:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab1BETId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 14:08:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64540 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab1BETIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 14:08:32 -0500
Received: by iwn9 with SMTP id 9so3278829iwn.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 11:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Yuyp3HWsgWpndIbP+grc7eqTxLr6a2iEznbU9DF96qI=;
        b=l1JARQjMQZv0wwr81IGiGHUfo5OCPaE+1936uRg3OilwYir7BiS35eW7bxr58KFFsy
         k2btzBC3NEwdcxKohZoRP5V9GLmhlgYwqopJMZiQ537zXLNvJAp0L8y+7wQvuC36/8h3
         lN8xuJBUMgOssv5VIflr4ddWcqmBrAC6kfjXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H2i967e/Ai2F5dZb5KVUR96OY0Cn6bD2QIsT4Y19mF4xvGONrWIF33riCU3lnqXSLp
         eGyP3DG0F/qJqBmtTz56GkdwoAEVsag2q9g3hKOP9hwMc7t69/aSkiWnEzp6Ivc5eSuX
         hjq7wNutKy6LIEeTP/sQFkOeka2IjMfeHHxh8=
Received: by 10.42.229.129 with SMTP id ji1mr2678218icb.343.1296932912362;
 Sat, 05 Feb 2011 11:08:32 -0800 (PST)
Received: by 10.42.135.7 with HTTP; Sat, 5 Feb 2011 11:08:32 -0800 (PST)
In-Reply-To: <AANLkTi=E3gWG2-3nLBW6JP+Wks2=4oUWSNSpk0=qEaU-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166113>

2011/2/5, Sverre Rabbelier <srabbelier@gmail.com>:
[...]
> What happens if you lay out your repo like the urls? I.e. without the
> "http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git"
> prefix?

I 1st want to thank you for this suggestion.

However,

This was one of the 1st things I tried in order to get a
fully-functional repository.

I think that I should be able to re-construct the whole repository from
this set of a few .pack files (450MiB) I just downloaded.
    ( .idx files are only there for optimization purpose )

How can I do that ?

    ! THAT'S THE QUESTION !

Yet,

I thank you for your answer.

Sincerely,

Valentin
