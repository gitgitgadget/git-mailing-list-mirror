From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-1.5.5
Date: Mon, 26 Feb 2007 18:39:13 +0100
Message-ID: <e5bfff550702260939t4a071d34o6bbf3dcd4ad5b67c@mail.gmail.com>
References: <e5bfff550702250958n6cddc5b5lec4badf1f7fc8231@mail.gmail.com>
	 <46a038f90702251623h5944a085m514418cb5f530e7f@mail.gmail.com>
	 <e5bfff550702252219m352c03ady2d810e051bd62a37@mail.gmail.com>
	 <Pine.LNX.4.63.0702261218430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 18:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLjor-00086g-G5
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 18:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbXBZRjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 12:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbXBZRjV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 12:39:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:21233 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030362AbXBZRjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 12:39:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so858224uga
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 09:39:17 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nps9IXrW2eM0Or78UswCdOvB79fHNxuzgDO5T+tZ2512qDuATMIQmtzq8dLV2+J+0VHmuHkHkndst81TIUUavD0QpMyhEpZ3jT9QbPqkMGI/MVLNCGsSOygn+bDx3zGDqsWeE86jrT44hjeV6Q+8kNmtLHBNOmmVemACT/UIXr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gguirhklR6VjcfPdCgkv3JkR7aWPvK+6IoSNrnDeUtP6Rf50FDQmK/vm9Aivuj7Lft/yhi2FFRHZ5n5vxLbg9zrYWEL7a5x7/88MThc3M+9yHchze1bQHO7lmBQoWKnE0lCZ2jB6XD2mDBbnbg8OM9ph/IBb65b6bi4jh1aQC4c=
Received: by 10.115.58.1 with SMTP id l1mr51775wak.1172511553232;
        Mon, 26 Feb 2007 09:39:13 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Mon, 26 Feb 2007 09:39:13 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702261218430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40635>

On 2/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 26 Feb 2007, Marco Costalba wrote:
>
> > On 2/26/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > > On 2/26/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > > > P.S: There is also a Qt4 version (works under Windows) downloadable
> > > > from git://repo.or.cz/qgit4.git  it is a little bit experimental
> > > > tough.
> > >
> > > Is the QT4 Windows port working against the MinGW port of GIT?
> > >
> >
> > Yes, Qt4Windows does not need cygwin at all and is compiled itself with
> > MinGW.
>
> I think what Martin was getting at is if you can use the MinGW port of
> _Git_, not if Qt4Windows or qgit needs cygwin.
>

Actually, I didn't test with MinGW port of Git but I would be
surprised if it doesn't work (famous last words ;-)  )


Marco
