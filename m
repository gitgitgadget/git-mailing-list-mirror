From: David Lang <david@lang.hm>
Subject: Re: VCS popularity
Date: Tue, 31 Mar 2015 15:03:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1503311502240.26359@nftneq.ynat.uz>
References: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-184397768-1427839402=:26359"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=D8yvind_A=2E_Holm?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:03:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4Fy-0007yu-LA
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbbCaWDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:03:25 -0400
Received: from mail.lang.hm ([64.81.33.126]:50913 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbbCaWDY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:03:24 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t2VM3M1B023566;
	Tue, 31 Mar 2015 14:03:22 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266563>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-184397768-1427839402=:26359
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 31 Mar 2015, Øyvind A. Holm wrote:

> openhub.net (formerly ohloh.net) has an interesting comparison of the
> number of public repositories on the net, based on searches of popular
> hosting services. This comparison is available at
> <https://www.openhub.net/repositories/compare> and shows an estimated
> market share between Bazaar, CVS, Git, Mercurial and Subversion.
>
> I've been monitoring this since 2014-08-05 to see how things were
> developing, and it's a good indication of the popularity of the various
> version control systems.
>
> I've created a repository at
> <https://github.com/sunny256/openhub-repositories> where the project
> scripts and data files are stored, along with graphs in SVG format.
>
> The graphs are pretty interesting:
>
> https://github.com/sunny256/openhub-repositories/blob/master/graph/relative.svg
>  Graphs of relative growth between the various version control systems.
>
> https://github.com/sunny256/openhub-repositories/blob/master/graph/relative-zoom.svg
>  Zoomed-in version of relative.svg. Git goes through the ceiling.
>
> https://github.com/sunny256/openhub-repositories/blob/master/graph/repos.svg
>  Total number of repositories.

number of repositories is an interesting datapoint, but activity in the repos 
would be far more interesting. There are a lot of repos of various types out 
there that haven't been touched for years.

David Lang
--680960-184397768-1427839402=:26359--
