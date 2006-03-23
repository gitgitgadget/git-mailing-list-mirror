From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 00:36:53 +0200
Message-ID: <20060324003653.b1cd7624.tihirvon@gmail.com>
References: <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
	<BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
	<Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
	<20060323.133120.69312511.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, seanlkml@sympatico.ca, keithp@keithp.com,
	hpa@zytor.com, jbglaw@lug-owl.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 23:37:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMYQT-0001LR-52
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 23:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWCWWg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 17:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWCWWg4
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 17:36:56 -0500
Received: from nproxy.gmail.com ([64.233.182.191]:2736 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932528AbWCWWgz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 17:36:55 -0500
Received: by nproxy.gmail.com with SMTP id m19so348655nfc
        for <git@vger.kernel.org>; Thu, 23 Mar 2006 14:36:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=D9c1sLUrgblf13Sw+KG82UBdb+WTUv7Xn9bg+efdGAWuWYqUvc1yODlhGqw7HxBEgPA7+dKbbgTzQKK9WbHzzwoNoGZj4+Kn7qW527YSAoK3QOJ/IDBL5BOlwcRQS5hoYuwYOWJZnbgr+rlNBvV3b+/FhyzcOyIb8PbuMBJ0Smk=
Received: by 10.49.61.14 with SMTP id o14mr747478nfk;
        Thu, 23 Mar 2006 14:36:53 -0800 (PST)
Received: from garlic.home.net ( [82.128.203.119])
        by mx.gmail.com with ESMTP id i1sm1572175nfe.2006.03.23.14.36.50;
        Thu, 23 Mar 2006 14:36:52 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20060323.133120.69312511.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17880>

On Thu, 23 Mar 2006 13:31:20 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> From: Linus Torvalds <torvalds@osdl.org>
> Date: Thu, 23 Mar 2006 12:38:33 -0800 (PST)
> 
> > Yeah, I'm not counting things like Eclipse etc. I'm talking about "plain 
> > SCM" environments, ie just basic SVN or CVS. What are we missing in that 
> > department? (The only thing I can think of is a diff colorizer, which some 
> > prople seem to really want).
> 
> gitk does color the diffs already, or are we talking about some
> "side-by-side" multiple window thing showing "before" on the
> left and "after" on the right?

Colorized "git diff", like cg-diff.  Vim users can use vimpager instead
of less.

-- 
http://onion.dynserv.net/~timo/
