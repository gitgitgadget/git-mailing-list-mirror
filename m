From: Pete Wyckoff <pw@padd.com>
Subject: Re: Suggested improvements to the git-p4 documentation
 (branch-related)
Date: Sat, 23 Feb 2013 09:48:03 -0500
Message-ID: <20130223144803.GA5444@padd.com>
References: <CAFXk4bqt_pMVDtVKF-JiQuGbSpy2+_rGOg5RTTE+0pNKFcZh3w@mail.gmail.com>
 <20130105212517.GA30315@padd.com>
 <CAFXk4bp0MBNxOD7w1zn7peN-ufWmV=DthMdHmjmj+Sci4MGneg@mail.gmail.com>
 <7va9qvc13r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Delalleau <shish@keba.be>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 15:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9GOx-00015I-1M
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 15:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866Ab3BWOsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 09:48:11 -0500
Received: from honk.padd.com ([74.3.171.149]:49450 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089Ab3BWOsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 09:48:08 -0500
Received: from arf.padd.com (unknown [50.124.137.41])
	by honk.padd.com (Postfix) with ESMTPSA id 73A655B67;
	Sat, 23 Feb 2013 06:48:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B1DF722A51; Sat, 23 Feb 2013 09:48:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7va9qvc13r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216897>

gitster@pobox.com wrote on Fri, 22 Feb 2013 16:42 -0800:
> Olivier Delalleau <shish@keba.be> writes:
> 
> > 2013/1/5 Pete Wyckoff <pw@padd.com>:
> >> shish@keba.be wrote on Thu, 03 Jan 2013 15:58 -0500:
> > ...
> >> Please do feel welcome to to rearrange or expand the
> >> documentation so it makes more sense, if you are so inspired.
> >
> > I'm afraid I'm not familiar enough with git documentation to dig into
> > it myself, but anyway that's about what I had for now. I'll send more
> > comments to the mailing list if I have more suggestions in the future.
> >
> > Thanks for a great tool! :)
> 
> Did anything come out of this thread?  If neither of you two are
> inclined to conclude the discussion with a final patch, I'd
> appreciate anybody else who does the honors ;-)
> 
> We'll be in deep pre-release freeze for a few weeks, so there is no
> need to rush.

Two of Olivier's suggestions were best classified as code, not
documentation, bugs.  I finished off some ongoing work that fixed
those along the way.  The third led to a fix to the
documentation, 182edef (git p4 doc: fix branch detection example,
2013-01-14), that I added as part of that series.

All of it is in master now, via 801cbd7 (Merge branch
'pw/p4-branch-fixes', 2013-01-21).

I should have commented on this thread too.  Thanks for following
up!

		-- Pete
