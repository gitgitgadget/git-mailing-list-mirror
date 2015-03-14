From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: [PATCH 3/3] push: allow --follow-tags to be set by config
 push.followTags
Date: Sat, 14 Mar 2015 10:50:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.11.1503141049080.16979@narbuckle.genericorp.net>
References: <20150216061051.GA29895@peff.net> <20150216061619.GC32381@peff.net> <xmqqh9toxgdd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Olszewski <cxreg@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 18:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWqCj-0003Zf-7G
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 18:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbbCNRuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 13:50:24 -0400
Received: from 63.f9.1243.static.theplanet.com ([67.18.249.99]:35543 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751153AbbCNRuX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2015 13:50:23 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.14.4/8.14.4/Debian-8) with ESMTP id t2EHoK0s021433
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 14 Mar 2015 12:50:20 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <xmqqh9toxgdd.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265455>

On Fri, 13 Mar 2015, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > From: Dave Olszewski <cxreg@pobox.com>
> >
> > Signed-off-by: Dave Olszewski <cxreg@pobox.com>
> > ---
> > Again, this is just a preview. Dave should send the final when he thinks
> > it is good.
> 
> Dave?
> 
> I do not see anything wrong with this version that builds on top of
> the previous 2 clean-up.  Personally I find that these clean-up
> changes more valuable than I care about this particular feature, and
> it is unfortunate that waiting an Ack or reroll of this one kept
> them stalled.
> 
> I am tempted to throw "Helped-by: Peff" into the log message and
> merge the result to 'next', unless I hear otherwise in a few days.

Sorry, work has kept me very busy lately, I haven't had time to re-visit
this.  Jeff's version looks great to me, please go ahead with it.
Thanks everyone.

    Dave
