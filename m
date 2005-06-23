From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 20:47:03 +1200
Message-ID: <46a038f9050623014755acb1c6@mail.gmail.com>
References: <Pine.LNX.4.21.0506221654550.30848-100000@iabervon.org>
	 <Pine.LNX.4.58.0506221504370.2353@ppc970.osdl.org>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 10:52:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlNRD-0000ii-7I
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 10:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVFWIxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 04:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVFWItV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 04:49:21 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:52454 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262630AbVFWIrD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 04:47:03 -0400
Received: by rproxy.gmail.com with SMTP id i8so225179rne
        for <git@vger.kernel.org>; Thu, 23 Jun 2005 01:47:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fUDbob1pOYxzL2XevRYrdA945DPO32p6/sBA6m6g6bSEVvOefdrUkRDmC48kxrdH5rjlkq0qqjHGmCvXC7BOP5cU8aQgpRs2CDyAmab1smNgO5MKiv9uJ4sfKjcN1vbrOKK96IGiOJKdPj7YNWCpdG9QMm9bTNs/r6Cp11/3Y/M=
Received: by 10.39.2.65 with SMTP id e65mr743865rni;
        Thu, 23 Jun 2005 01:47:03 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Thu, 23 Jun 2005 01:47:03 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221504370.2353@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/23/05, Linus Torvalds <torvalds@osdl.org> wrote:
> I've been doing unified diffs for a _loong_ time, and I edit patches in my
> sleep. The rules for line numbers etc are really quite simple, and yes, I
> do edit patches before I apply them.

We often do unified diff editing when dealing with merge conflicts. It
isn't too hard once you've got the hang of it, usually the hard thing
is resolving the conflict in the first place.

Emacs has a diff editing mode that is really good:
http://wiki.gnuarch.org/Process_20_2a_2erej_20files

cheers,


martin
