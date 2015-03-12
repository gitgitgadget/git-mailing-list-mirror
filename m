From: Jeff King <peff@peff.net>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 18:38:36 -0400
Message-ID: <20150312223836.GB24492@peff.net>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net>
 <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
 <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
 <20150311073129.GA5947@peff.net>
 <xmqq61a64xg8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 23:38:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWBka-00020h-4z
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 23:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbbCLWik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 18:38:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:60720 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbbCLWij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 18:38:39 -0400
Received: (qmail 14429 invoked by uid 102); 12 Mar 2015 22:38:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 17:38:39 -0500
Received: (qmail 7133 invoked by uid 107); 12 Mar 2015 22:38:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 18:38:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2015 18:38:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61a64xg8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265379>

On Wed, Mar 11, 2015 at 10:05:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I spent many years as a "type C" contributor, and I remember how nice it
> > was to see my name mentioned occasionally as a useful person.
> 
> I guess that everybody is different ;-)
> 
> After throwing a small patch at ROCKbox (git.rockbox.org) back when
> they were still hosted on Subversion, I felt somewhat ashamed to see
> my name appear in their CREDITS file because the change I made was
> so insignificant. In such a flat list like that, you cannot tell who
> made significant contributions over time and who are just a casual
> drive-by contributor like me, unless you know the community and who
> are important in the community.

Heh. Actually, after writing that, I almost clarified, but did not think
anybody was that interested. But since you replied...:)

Seeing my name in "shortlog" was nice, but not that exciting. I
submitted a patch, it was taken, and of course it ends up in any
automated lists of authors. What was much more rewarding was being
mentioned specifically in "A note from the maintainer" as a helpful
person. That had much more value because:

  1. It was one of a handful of names.

  2. It was picked by a human.

So in that sense, it is quite the opposite of including shortlog output
in the release announcements (I still think the shortlog thing we have
been discussing is a good thing, but not at the same level). I do not
know that it is worth having a "Best of 2015" Git awards ceremony, but
it is sometimes nice to thank people personally when you appreciate
their efforts. I sometimes mail people off-list to do so.

-Peff
