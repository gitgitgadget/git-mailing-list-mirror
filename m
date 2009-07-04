From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question
	about announcing it
Date: Fri, 3 Jul 2009 18:26:36 -0700
Message-ID: <20090704012635.GB39268@gmail.com>
References: <200907030130.24417.jnareb@gmail.com> <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Graham Perks <graham@kace.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 03:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMu1j-00086F-F5
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 03:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbZGDB0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 21:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbZGDB0h
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 21:26:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:1466 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbZGDB0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 21:26:37 -0400
Received: by wa-out-1112.google.com with SMTP id j5so539517wah.21
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FsA53uIuzjbBrEbiBJmDWOn1NEXP8OY+SY2kIqPxT7E=;
        b=u4rr99J7UTiE/95yXL1+WpeqdsNXgdtMYaI95qXHOqc5R/Fxi4M5cuOkmy61QPBqGw
         3hBe5uiArKGe6QW1OE8zVmJK9Y6GwCW64OjpmZCw640B3Nj9MnYkFY8LyRJPkhuejOMD
         JYgWH7p8BKmBP9sCju/vZWPZuPu9p9pjPQdh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HUE/rizb9i6WBEkqDlm0lvANx8hjLc1wHcLXO9YqboKxy/70Wyd5l0a4DLJfnlFrmr
         YvsEojYW5/upmTRmLET3SidnaYkIWwugKrdI8MlCzpdXyeNOh9+DPtiQdU90qwb7tQn8
         JrdxHZ4qAWpYtzzoIyiuuEjkBKqXLKj0Q48Tk=
Received: by 10.114.185.12 with SMTP id i12mr2977117waf.16.1246670799472;
        Fri, 03 Jul 2009 18:26:39 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j28sm7128111waf.67.2009.07.03.18.26.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 18:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122713>

On Sat, Jul 04, 2009 at 02:19:25AM +0300, Felipe Contreras wrote:
> 2009/7/3 Jakub Narebski <jnareb@gmail.com>:
> 
> > 20. Overall, how happy are you with Git?
> >    * unhappy
> >    * not so happy
> >    * happy
> >    * very happy
> >    * completely ecstatic
> 
> Let's leave room for git haters too:
>  * I hate it

Umm, let's not.

If they hate it, they'll be in the "unhappy" category.
And if they hate it, I doubt they'll be filling out this survey.

I've heard nothing but unhelpful, uneducated, and stubborn words
from people who "hate git".  They usually have nothing productive
to say and spend their time complaining about really petty things
like the fact that they have to paste in a SHA-1 every now and
then.  Worse still, they almost never have constructive
criticism and thus will always be upset.

Personally, I couldn't care less to hear what they have to
say.  The only thing worse then the haters are the ones who
actually believe that they would hate hg less
(even when they've never tried hg!).

Let's not encourage them by including including "I hate git"
in our survey.

No thanks.

> - 21. In you opinion, which areas in Git needs improvement?
> + 21. In you opinion, which areas of Git need improvement?

- 21. In you opinion, which areas of Git need improvement?
+ 21. In your opinion, which areas of Git need improvement?
         ^^^^

Have fun,

-- 
		David
