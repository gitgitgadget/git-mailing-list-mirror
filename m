From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 20:51:43 +0100
Message-ID: <e5bfff550702081151q5536b547p34728cafa9a7dee@mail.gmail.com>
References: <200702072138.36787.andyparkins@gmail.com>
	 <200702081020.44202.andyparkins@gmail.com>
	 <e5bfff550702081106u1e02f371g3a91c7462ff5e442@mail.gmail.com>
	 <200702081913.09952.andyparkins@gmail.com>
	 <e5bfff550702081129x6c94eaa4p40cf09e70c4e09cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:52:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFJc-0001WN-GZ
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423299AbXBHTvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423305AbXBHTvp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:51:45 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:53784 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423299AbXBHTvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:51:44 -0500
Received: by wr-out-0506.google.com with SMTP id 68so636226wri
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 11:51:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ie2ztdK+fbOYeqWFgcthrX1oqSyU5LzJWQskxWfkZNHXtYm8sKAVN6aQ58kyLIb0kIAGDk2cEMzUGq58T3mafecO+yXCUoLKJqb0g4ehmwX8sU5hV7aaa2FsHly1vYtbWPtkr0n2Vf6P1welpOGWZGei9AlLHnEcWIn4OpoxyLk=
Received: by 10.115.89.1 with SMTP id r1mr3727173wal.1170964303549;
        Thu, 08 Feb 2007 11:51:43 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Thu, 8 Feb 2007 11:51:43 -0800 (PST)
In-Reply-To: <e5bfff550702081129x6c94eaa4p40cf09e70c4e09cd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39081>

On 2/8/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 2/8/07, Andy Parkins <andyparkins@gmail.com> wrote:
> > On Thursday 2007, February 08 19:06, Marco Costalba wrote:
> >
> > > I have applied and pushed all your patches. BTW you are referring to
> > > qgit4 at Pasky http://repo.or.cz/ site, not the stable qgit in
> > > kernel.org repo!
> >
> > My apologies - that was the first one I found when I typed qgit4
> > repository.
> >
>
> No problem, stable qgit has less layout problems, probably the only
> patch I will back port is the fixed font in log viewer.
>

And also the short log resize mode one, sorry, I forget to mention.

BTW it's a little bit funny when you try to resize with mouse the
author column and see short log column moving instead :-)


Marco
