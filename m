From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 20:43:58 -0400
Message-ID: <9e4733910607271743o3b7a27d5v55a216745937c74e@mail.gmail.com>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
	 <20060727114105.GZ13776@pasky.or.cz>
	 <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
	 <20060727131127.GA13776@pasky.or.cz>
	 <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
	 <eablgn$c6a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 02:44:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6GST-0003ad-NR
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 02:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWG1AoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 20:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWG1AoA
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 20:44:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:42156 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750972AbWG1AoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 20:44:00 -0400
Received: by ug-out-1314.google.com with SMTP id m3so548155ugc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 17:43:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GIxnjhnGCPuMzivfqnW1wvBZLfrzZWJB8xdgT8HaHQknSvhxetpY7/qKLD3YrnE2qqMQmzIBlmuBZR6lpXGxk3uRGpJSak+5O817hurJ6OW4/MCbkQg5iFlC/Bj7OO3Dz5YKIUF4uok3I712MaxwlQILe1+09afjapGEgB6tLMo=
Received: by 10.78.183.8 with SMTP id g8mr686277huf;
        Thu, 27 Jul 2006 17:43:59 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Thu, 27 Jul 2006 17:43:58 -0700 (PDT)
To: "Anand Kumria" <wildfire@progsoc.org>
In-Reply-To: <eablgn$c6a$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24358>

On 7/27/06, Anand Kumria <wildfire@progsoc.org> wrote:
> On Thu, 27 Jul 2006 12:11:00 -0400, Jon Smirl wrote:
>
> > On 7/27/06, Petr Baudis <pasky@suse.cz> wrote:
> >> > You may like trying to force GPL onto the app but many apps are
> >> > stuck with the license they have and can't be changed since there is
> >> > no way to contact the original developers.
> >>
> >> At this point, git-shortlog lists exactly 200 people (at least entries
> >> like Unknown or No name are all linux@horizon.com ;-).
> >
> > Inability to integrate with Microsoft Visual Studio is going to have a
> > lot of impact on the cross platform use of git.
>
> Could you stop with the histrionics please?

It is usually wise not to make comments like this, they don't help in
building the community.

> > Is a conscious
> > decision being made to stop this integration or is this just unplanned
> > side effect of the original license? If this is an unplanned side
> > effect, the quicker we move, the easier it is to fix.
>
> So, using CVSNT (a GPL'd SCCI provider) and git-cvsserver would be a way
> to continue.  I'm assuming that the primary functionality they want via
> their IDE is checkout/diff/commit/log.

Now, that's a great strategy. Tell the large project you are
interested in switching off from CVS to git that they need to run a
CVS emulation gateway forever. I don't think a switch has much of a
chance of happening.


> Quite a lot of Windows developers have no problems using multiple tools
> for things, I'd assume they would also be able to use any existent port
> of git (to Windows) to do the esoteric things like branching/bisect/etc.
>
> Anand
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
