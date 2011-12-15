From: Paul Mackerras <paulus@samba.org>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered
 by path
Date: Fri, 16 Dec 2011 10:01:24 +1100
Message-ID: <20111215230124.GH20629@bloggs.ozlabs.ibm.com>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
 <CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
 <alpine.DEB.1.00.1112151023280.2615@bonsai2>
 <CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
 <7v1us5obqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 00:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbKJl-0003oQ-6a
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 00:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759733Ab1LOXCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 18:02:18 -0500
Received: from ozlabs.org ([203.10.76.45]:57101 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759708Ab1LOXCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 18:02:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id E30431007D5; Fri, 16 Dec 2011 10:02:15 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7v1us5obqa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187254>

On Thu, Dec 15, 2011 at 11:50:53AM -0800, Junio C Hamano wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > Paul and Junio, the patches I sent in April are still not in git.git,
> > are they? Can we use another repo until the kernel.org one is up? More
> > than eight months to get a patch (or eight) merged is way too long,
> > IMO.
> 
> I tend to agree.
> 
> I have this slight suspicion that Paul would appreciate if somebody who
> cares about gitk who is capable and willing steps forward and takes over
> the maintainership of gitk, as he is busy in his other projects.

Indeed.  For now I have put up a repository on ozlabs.org:

git://ozlabs.org/~paulus/gitk.git

but if someone wants to take on the gitk maintainership, please let me
know.

Paul.
