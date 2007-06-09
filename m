From: "A.J. Rossini" <blindglobe@gmail.com>
Subject: Re: problems with cloning; http vs git protocols?
Date: Sat, 9 Jun 2007 17:57:15 +0200
Message-ID: <1abe3fa90706090857s4360aa4dpe742da8776019858@mail.gmail.com>
References: <1abe3fa90706090806m4014a680x89178bc5698fefda@mail.gmail.com>
	 <20070609155521.GA3577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 17:57:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx3JW-0007MD-8l
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 17:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbXFIP5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbXFIP5R
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 11:57:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:3271 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbXFIP5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 11:57:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1464172wah
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 08:57:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gJgixzy0ObLwuHBLwS+kAP6/Ad3BNZ0ZbcGd9arWWVQB6rDsvVLwZAlRXp6OvLDL74sCqcd/P6h/bVAZmyTzmVRgpOVdaloJYWPtVtG/Ye9VqAQVI5bnQDVOKZw3SbIl5N0E38ZZiMUD3/QA++xkAgNKDBDoSf/U+onIf0EZ7BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CsOEIRoJUUbwZXyjSqqy5y1gct6FOGaMSAvAoyk1wjmdSby6/PAET+NcdtCM+IkVNcqq+EgW9sQAU123KfLJIU3K8Q3UT/drW/ZNknO8wU4MX/Jy6ypQsuO/MF6YFpsIY9pu2wx6c7b9bdSsjFbkLe2EysOrXYlw97O/kxjr8O8=
Received: by 10.114.112.1 with SMTP id k1mr3753582wac.1181404635828;
        Sat, 09 Jun 2007 08:57:15 -0700 (PDT)
Received: by 10.114.38.4 with HTTP; Sat, 9 Jun 2007 08:57:15 -0700 (PDT)
In-Reply-To: <20070609155521.GA3577@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49579>

Thanks much for politely pointing out my cluelessness.  Honestly much
appreciated!

best,
-tony


On 6/9/07, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 09, 2007 at 05:06:05PM +0200, A.J. Rossini wrote:
>
> > I've been working to verify it to write instructions for friends, and
> > here is the basic problem:
> >
> > git clone http://repo.or.cz/w/rclg.git
>
> That's the gitweb URL. Try visiting it in your web browser. The
> git-over-http URL is:
>   http://repo.or.cz/r/rclg.git
>
> -Peff
>


-- 
best,
-tony

blindglobe@gmail.com
Muttenz, Switzerland.
"Commit early,commit often, and commit in a repository from which we
can easily roll-back your mistakes" (AJR, 4Jan05).
