From: Sebastien Cevey <seb@cine7.net>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Wed, 21 Jan 2009 15:28:26 +0100
Message-ID: <1232548106.4977310a95d8f@mail.nimag.net>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org> <m3ljthzzdq.fsf@localhost.localdomain> <7vwsd1pjst.fsf@gitster.siamese.dyndns.org> <200901120225.30175.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 15:37:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeC4-0003uL-KN
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbZAUOfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 09:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbZAUOfM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:35:12 -0500
Received: from mail.hebweb.net ([62.220.136.4]:51737 "HELO
	mail-unsh.hebweb.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754203AbZAUOfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 09:35:11 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jan 2009 09:35:10 EST
Received: (qmail 27771 invoked by uid 33); 21 Jan 2009 14:28:26 -0000
Received: from 146.101.142.69 ([146.101.142.69]) 
	by mail.nimag.net (IMP) with HTTP 
	for <postmaster@cine7.net@mail.nimag.net>; Wed, 21 Jan 2009 15:28:26 +0100
In-Reply-To: <200901120225.30175.jnareb@gmail.com>
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 146.101.142.69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106609>

Selon Jakub Narebski <jnareb@gmail.com>:

Hello,

Sorry for not responding earlier, I was quite busy being ill and moving abroad
for a new job.

> >>> ----------------------------------------------------------------
> >>> [Actively cooking]
> >>>
> >>> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
> >>>  - gitweb: Optional grouping of projects by category
> >>>  - gitweb: Split git_project_list_body in two functions
> >>>  - gitweb: Modularized git_get_project_description to be more generic
> >>
> >> This I think needs some further cooking.  I guess with addition of one
> >> more patch to series categories could be sorted together with projects
> >> they contain, and not always have to be in fixed ordering.
> > 
> > These should be moved to the Stalled category; nobody seems to be
> > discussing improvements and sending updates to the series as far as I
> > recall.
> 
> I think it is just the author being slow moving; there was quite
> a bit of time between subsequent versions of this patch series.

I don't recall what was left to do on top of the series of patches I submitted,
could you refresh my mind on that if it still needs to be done? I remember the
discussion trailing off as categorized ordering was being discussed..

-- 
Sebastien Cevey - inso.cc
