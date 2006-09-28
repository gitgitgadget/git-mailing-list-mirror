From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 15:12:37 -0700 (PDT)
Message-ID: <20060928221237.85837.qmail@web51015.mail.yahoo.com>
References: <451C3494.8030701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 00:14:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT47Z-0001t8-8V
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWI1WMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWI1WMj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:12:39 -0400
Received: from web51015.mail.yahoo.com ([206.190.39.80]:19843 "HELO
	web51015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751024AbWI1WMi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 18:12:38 -0400
Received: (qmail 85839 invoked by uid 60001); 28 Sep 2006 22:12:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WrYOa9kLYObc8/5jMxapfbWV/9dHMEEk5unYljjMTF2nf7sKcACA5mvyqHMjEcMVDUpIenfZtXO/G5Ve2VyRHrszbMx22ft8dAlC+bGT4sxZ5UozoLdjfzEbUgvuZOs93ioQrPo23DPyBpB+Vpx1JWOw0NPVVEv9LwIGVSKm4C0=  ;
Received: from [207.172.80.85] by web51015.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 15:12:37 PDT
To: git@vger.kernel.org
In-Reply-To: <451C3494.8030701@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28055>

--- A Large Angry SCM <gitzilla@gmail.com> wrote:

> Sounds like you're suggesting that Git should not record any timestamps 
> at all. After all, Git doesn't need them.

Yeah kind of, since distributed git doesn't need timestamps and can't guarantee them the only time
that might make any sense to use locally is local commit time. 

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
