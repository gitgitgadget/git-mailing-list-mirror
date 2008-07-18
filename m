From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 13:56:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807181356010.3932@eeepc-johanness>
References: <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 13:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJoaE-0003fm-2x
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 13:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbYGRL4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 07:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbYGRL4L
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 07:56:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:47458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751873AbYGRL4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 07:56:10 -0400
Received: (qmail invoked by alias); 18 Jul 2008 11:56:07 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp009) with SMTP; 18 Jul 2008 13:56:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qJMpH4vdqqDq1uyaPhNpNtDr6mHNnX4Z1z5D5Ct
	Atvd6zcDOpGYBs
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080718175040.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89033>

Hi,

On Fri, 18 Jul 2008, Nanako Shiraishi wrote:

> Quoting Junio C Hamano <gitster@pobox.com>:
> 
> > * xx/merge-in-c-into-next (Wed Jul 9 13:51:46 2008 -0700) 4 commits
> >  + Teach git-merge -X<option> again.
> >  + Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
> >  + builtin-merge.c: use parse_options_step() "incremental parsing"
> >    machinery
> >  + Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next
> >
> > This needs to be merged to master iff/when merge-theirs gets merged, 
> > but I do not think this series is widely supported, so both are on 
> > hold.
> 
> Why do you say it is not widely supported?  I may be wrong but I think 
> you developed these patches after somebody from the mailing list asked 
> for this feature.

Asking for a feature, and then not doing a single thing to defend why it 
makes sense, of a single person, who does not even speak up now, does not 
count for "wide support".

Ciao,
Dscho
