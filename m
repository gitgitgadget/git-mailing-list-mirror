From: "Gerb Stralko" <gerb.stralko@gmail.com>
Subject: Re: GIT and the current -stable
Date: Sat, 14 Apr 2007 14:45:53 -0400
Message-ID: <75b57c110704141145r2b371d5dpbcf915973b83789a@mail.gmail.com>
References: <46206842.80203@gmail.com>
	 <7vfy73bhik.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0704141028460.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Rene Herman" <rene.herman@gmail.com>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>,
	"Greg KH" <greg@kroah.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 20:46:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcnG3-0007f5-NV
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 20:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbXDNSpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 14:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965528AbXDNSpz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 14:45:55 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:22815 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965105AbXDNSpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 14:45:54 -0400
Received: by nz-out-0506.google.com with SMTP id s1so989517nze
        for <git@vger.kernel.org>; Sat, 14 Apr 2007 11:45:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=anBM/P//ZZ6+QUPlvkQciwo5Cc6fBJB+1imWUsKySIjDgKgH/oR4AL8TQCj/rffNtr8lpLjWKjyGLww7NMPdeBSj0XFvXXYJucLj+aws3gtQUxnLttek1xWo3XaV3bN+X2ak9WtfkpMr/S8lda40TSz1HFYMeRmREO0YdC5Ritk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DRkfFKke3HtvSih4ntWkemf/SaLGV3206VdL/BAKukm/ApflwehVfWK2G/Ifoj2REAP7T22EMpRJL/AxB28cgeYHgohax42N1Kgivfr1IifN38F4D443Y7aO/a5en7JPtDH+TBt1LxdToB4RZPQx5GBkaz5VdWagvy8wL5ou0cg=
Received: by 10.114.168.1 with SMTP id q1mr1445403wae.1176576353691;
        Sat, 14 Apr 2007 11:45:53 -0700 (PDT)
Received: by 10.114.127.11 with HTTP; Sat, 14 Apr 2007 11:45:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704141028460.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44467>

> Please don't do this. Using the same name for a branch as for a tag is
> madness. Call it "v2.6.20-stable" or anything else, but don't re-use the
> same naming as for tags.
>

Yes I have done this before, and it took me awhile to realize what was
going on.  It caused me some grief, and a few hours of lost time...Of
course this was back in my earlier days ;)
