From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: Re: [Announce] gitview-0.1
Date: Wed, 1 Feb 2006 10:11:00 +0530
Message-ID: <cc723f590601312041o1dc594c7t69418b735ef29ee@mail.gmail.com>
References: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
	 <20060201042930.GV16557@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Feb 01 05:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F49nx-00071C-4r
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 05:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWBAElE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 23:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWBAElE
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 23:41:04 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:59313 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964915AbWBAElC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 23:41:02 -0500
Received: by uproxy.gmail.com with SMTP id q2so132419uge
        for <git@vger.kernel.org>; Tue, 31 Jan 2006 20:41:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m0dcwOTdfJyCX9dDnNeiIqmFfjjbqbc5iGcXMVOGHCL5chicMUArjqOFUteFtoyfnZRteJp3slO4Tl8QHD8r24irQEp3bqig0jbl2Q32RNhCr85FLKSuFhoXY+AvdGHmu3tM/t7o5Q3t8gYnIpJE9L4p1VU0zjRdWBCmlHEenMs=
Received: by 10.66.234.13 with SMTP id g13mr2507880ugh;
        Tue, 31 Jan 2006 20:41:00 -0800 (PST)
Received: by 10.66.254.16 with HTTP; Tue, 31 Jan 2006 20:41:00 -0800 (PST)
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060201042930.GV16557@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15385>

On 2/1/06, Dave Jones <davej@redhat.com> wrote:
> On Wed, Feb 01, 2006 at 09:46:59AM +0530, Aneesh Kumar wrote:
>
>  > I don't have a web location where i can host it so i am attaching it below.
>  > It would be great if we can get it added to git repository
>  >
>  > sample usage
>  > takes same argument as git rev-list
>  >
>  > gitview --since=2.week.ago
>
> Nice, here's your first patch against it :-)
>
> The one thing I like about gitk over this though is that with gitk
> you don't have to click a button to see the diff.
> For casual history browsing, it's much nicer to just scroll the bottom
> window. Making it pop up a new window for each diff is just irritating.
>

I always browse the repository looking at the commit message and only
if interested i look at the changes.  That's why i made it look that
way.

-aneesh
