From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Showing the version of a file that's in the Index.
Date: Wed, 8 Apr 2009 13:04:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904081303400.9157@intel-tinevez-2-302>
References: <c115fd3c0904071259y53b4b264u9c9957b68e36cc44@mail.gmail.com> <200904072210.05591.markus.heidelberg@web.de> <874ox0w7ak.fsf@iki.fi> <200904072357.47881.markus.heidelberg@web.de> <87y6ubvix7.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: markus.heidelberg@web.de, Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 08 13:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrVbL-0007RJ-KV
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 13:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659AbZDHLEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 07:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbZDHLEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 07:04:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:55844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751138AbZDHLEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 07:04:08 -0400
Received: (qmail invoked by alias); 08 Apr 2009 11:04:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp041) with SMTP; 08 Apr 2009 13:04:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lmjAbPdllljZi4leLr0LnJWlyQOTvV2FkvdrXDz
	g/opRS2/wCai9E
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <87y6ubvix7.fsf@iki.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116078>

Hi,

On Wed, 8 Apr 2009, Teemu Likonen wrote:

> On 2009-04-07 23:57 (+0200), Markus Heidelberg wrote:
> 
> > Teemu Likonen, 07.04.2009:
> >> Or
> >> 
> >>     git show :file
> >
> > Huh, I use git-show daily for commits, but I completely forgot about it
> > for files when replying.
> 
> It's nice for trees too:
> 
>     git show HEAD~3:
>     git show master~1:directory/

But that's not in the index, and my patch to show cache-trees was 
rejected.

Ciao,
Dscho
