From: <porpen@gmail.com>
Subject: Re: 'bad file' error updating from Linus
Date: Thu, 22 Sep 2005 08:42:23 -0400
Message-ID: <509c8057050922054272b823fe@mail.gmail.com>
References: <dgu56t$d2p$1@sea.gmane.org>
Reply-To: porpen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 14:43:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIQPF-0002wn-4i
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 14:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVIVMmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 08:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVIVMmY
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 08:42:24 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:27793 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030284AbVIVMmY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 08:42:24 -0400
Received: by qproxy.gmail.com with SMTP id f11so53946qba
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 05:42:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ovk8hRx/vnyNYjEXETgrmGbVVW6G1xlU3hWL3R7Ivu9njNza3m/+TTQi4/KDIRMyK0h481Rdop3XL+DzPhZ3a2uvZZwaSsgBJ+h7OeQusTBhnMY6GpdxMeimg6Ntp7NOprDFFp5H7lKmKqRSFowERYaVgDsQWojNqvA4xd/Xz5Q=
Received: by 10.65.84.4 with SMTP id m4mr169353qbl;
        Thu, 22 Sep 2005 05:42:23 -0700 (PDT)
Received: by 10.65.141.17 with HTTP; Thu, 22 Sep 2005 05:42:23 -0700 (PDT)
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dgu56t$d2p$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9114>

You aren't alone.  I had a look at http://www.kernel.org/git/  only to
find that the 2.6 kernel has been taken off the list...  /me thinks
Linus is pushing an update as I type.

On a whim, I'll suggest we relax and go get some breakfast. ;-)   and
try again a little later...

Cheers!
-P

On 9/22/05, walt <wa1ter@myrealbox.com> wrote:
> cg-update this morning is giving me this error:
>
> receiving file list ... done
> v2.6.14-rc2
>
> wrote 134 bytes  read 1116 bytes  833.33 bytes/sec
> total size is 738  speedup is 0.59
> Tree change: 044a500e46742d39d22f1781cfb64ba93b463e39:e98c07b9eabedfb1d7ebef61af475bdebe1dd64d
> error: unable to find e98c07b9eabedfb1d7ebef61af475bdebe1dd64d
