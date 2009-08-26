From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: Newbie / git / gitosis question
Date: Wed, 26 Aug 2009 19:38:35 +1000
Message-ID: <d2e97e800908260238p28bd6d27o6377f395df32b03c@mail.gmail.com>
References: <26ae428a0908260227k7ac6aeden9a4eae7ee95d4d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgF62-0001Tr-4E
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbZHZJqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756551AbZHZJqg
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:46:36 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:56100 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518AbZHZJqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:46:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so6182197and.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 02:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sdzC7cAf/ESYSne2dFYFBnk2W397zqkWNNQ8S5CaXU0=;
        b=uM18dt7/hvIuqb0Fgo0rM441dpUlInhivDOcCEgAoqxzflaZTOSKS0wPgcTVDuQt/L
         v7hckrf0vniaR/gpAeSEZDYMXgMTg0eUN/vQQa6R20HEiVID7jIDxDEHOYvAjr02tK9w
         dVT145FJy+t/rHW/Fruk9jmg+M5CVWFYAeT4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V7ZhLES1pxh2NZJ3HCvKgU/gbA+KJhwusl2LlYkBbZsYSJzeI8JGqH5J6VGaOvXhq4
         XtZKgmu+a1AM0XEDJ22KnANwGjWXS63d/nmSVWH8iRQXTRheFLEjZ1TEZDovPUptRyqM
         UkS9kuPeGjl9vwsp2jxNEW+7gBimr5LcoUbWM=
Received: by 10.101.98.9 with SMTP id a9mr7381944anm.160.1251279535150; Wed, 
	26 Aug 2009 02:38:55 -0700 (PDT)
In-Reply-To: <26ae428a0908260227k7ac6aeden9a4eae7ee95d4d45@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127083>

2009/8/26 Howard Miller <howard@e-learndesign.co.uk>:
> I've been working away at Gitosis and it's mostly fair enough but
> there's one bit that's unclear to me...
>
> git push origin master:refs/heads/master
>
> Would somebody kindly explain (or point to docs) what
> refs/heads/master means? How is this different from just 'git push
> origin master' or even 'git push origin master:master'?
>
> Any insights much appreciated.

You might find some insight here - http://progit.org/book/ch9-5.html
