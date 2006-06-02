From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 16:16:37 +1200
Message-ID: <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Keith Packard" <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 06:16:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm15Z-00039s-70
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 06:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWFBEQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 00:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWFBEQm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 00:16:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:7609 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751313AbWFBEQm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 00:16:42 -0400
Received: by wr-out-0506.google.com with SMTP id 36so503834wra
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 21:16:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W52iLfQ1H/aF6oh2Z4Bgntb0ShlGIroXkQMh/evKgt0b5GmCuGNlHG93pigAb7ONc5e2sT/r2YEf760Hz5F745QAd+R/LiL8Cgh8/eSnhZ5Qn7+bo3TddGDnUM6QJVJvy+eueXJo/ZmCQES+NN3d0+rqnJyW2JfqJb8KrSwKgZ8=
Received: by 10.54.101.13 with SMTP id y13mr1381058wrb;
        Thu, 01 Jun 2006 21:16:38 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 1 Jun 2006 21:16:37 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21144>

On 6/2/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> It is going to have to be native Windows to move some of the
> developers over. They are true blue MS types that won't touch anything
> close to Unix so cygwin is out.

As others have pointed out, you have git-cvsserver which emulates a
CVS server on top of GIT, so it can be used with (almost any) CVS
client. They will be 2nd class citizens however...

cheers,


martin
