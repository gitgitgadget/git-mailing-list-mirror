From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: [wishlist] graphical diff
Date: Sun, 18 Mar 2007 22:39:09 +0100
Message-ID: <46d6db660703181439g277c2c67t22462d360cec5a7b@mail.gmail.com>
References: <1174223784.5987.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Raimund Bauer" <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT35t-0007JG-Ki
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbXCRVjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbXCRVjM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:39:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:14258 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbXCRVjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:39:11 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1152464uga
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 14:39:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VuWy31tiDAiQnNBMlnGoNbHooRGBDRtohxAJ2Bzot7Cd+A5DabzpUtDGFapYpXdTdDx1bIYLwq6zFPteKGu5OHSkln63E429qq7lWxV+aUCRzZT9JH+2iPLDtedUOjKRrNn2e+KCg9a3e5agnLQJaP4e8JxVDTwJLOeKsPRdL7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oCj/O5dgKdiqksu6yoDzMP9TvTDAtRm4c3uE26jY8bxyIHIDOuQdvwrnrKYMZAa+najYnhLV+aor7LgttssOLhzRUdvs0FCXJksqqpEyX7QDYb3wlpocsJj8P5lClSjij/xmTCeH+lGK1HnUMX+rq35IWVSM8b9sfF+l0DunBxo=
Received: by 10.65.151.6 with SMTP id d6mr6278705qbo.1174253949378;
        Sun, 18 Mar 2007 14:39:09 -0700 (PDT)
Received: by 10.115.16.8 with HTTP; Sun, 18 Mar 2007 14:39:09 -0700 (PDT)
In-Reply-To: <1174223784.5987.6.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42525>

On 3/18/07, Raimund Bauer <ray007@gmx.net> wrote:
> I think it would be really helpful (especially for newbies like me) to
> have an option like
>
> git diff --gui [revisions] <singe path spec>
>
> to fire up a graphical diff viewer (similar to what git-mergetool does).
>
> Another good place to start a graphical diff from is probably gitk from
> a context-menu for the changed files in the lower right pane.
>
> Thoughts?
>

gvimdiff is pretty cool. Have a look at the archives, I asked
recently how to perform this, and a few solutions came out
(you need a sane shell, and the abilities to create fifos).

I'd use it everyday if a true vim/gvim explorer plugin would
exist (and it's hard to code!).

-- 
Christian
