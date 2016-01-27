From: Eric Wong <normalperson@yhbt.net>
Subject: Re: What's cooking in git.git (Jan 2016, #05; Tue, 26)
Date: Wed, 27 Jan 2016 07:03:50 +0000
Message-ID: <20160127070350.GA32044@dcvr.yhbt.net>
References: <xmqqr3h3amtk.fsf@gitster.mtv.corp.google.com>
 <20160127025422.GB15119@dcvr.yhbt.net>
 <xmqqmvrra64u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:04:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOK9M-0002uc-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbcA0HEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:14 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49715 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbcA0HDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:51 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9C51F610;
	Wed, 27 Jan 2016 07:03:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqmvrra64u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284882>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Hi Junio, have you taken a look at:
> >   http://mid.gmane.org/20160116101719.GA21147@dcvr.yhbt.net ?
> >  ("git-svn: fix auth parameter handling on SVN 1.9.0+")
> 
> Yes, I did, and I also did notice that you said it should head to
> maint.  I was meaning to ask you if you were going to tell me to
> pull from you soon (as I know that you know that I know you know
> git-svn a lot better than I do), but forgot to do so.
> 
> If you prefer me to apply it directly to 'maint' and merge it up to
> 'master', I can do so, too.  I guess you are telling me that that is
> what you want to see happen here?

Yes, this fix can go directly to 'maint'.

I had some glob-related changes sitting in my repo you hadn't pulled
from me, yet, but those are only intended for master.  Thanks.
