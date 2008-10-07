From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 6/6] Refresh and expand the tutorial (not finished)
Date: Tue, 7 Oct 2008 09:12:23 +0200
Message-ID: <20081007071223.GC31332@diana.vm.bytemark.co.uk>
References: <20081005155450.19886.43748.stgit@yoghurt> <20081005160203.19886.33463.stgit@yoghurt> <b0943d9e0810061425u3ead1de5re1a252f03c2d09b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 09:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn6lO-0001jZ-Gz
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 09:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbYJGHMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2008 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbYJGHMg
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 03:12:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3630 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbYJGHMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 03:12:35 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kn6k3-0008CS-00; Tue, 07 Oct 2008 08:12:23 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0810061425u3ead1de5re1a252f03c2d09b3@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97678>

On 2008-10-06 22:25:45 +0100, Catalin Marinas wrote:

> 2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > This is a first pass at expanding the tutorial, fixing its
> > formatting, and updating it with the new things that have happened
> > in StGit.
> >
> > There are a number of things still left to do in the second half
> > of the document; they are tagged with "TODO".
>
> Thanks for this. Even with the TODOs, I think we can merge them into
> the master branch so that I have the same copy as you.

OK, that makes sense; "master" is, after all, a development branch. A
stable development branch, but still a development branch.

> Do you plan to do more work on the tutorial (so that we don't
> duplicate)?

I was planning to finish it if nobody else stepped up. But it'd be
great if I didn't have to do it alone. :-)

I guess we can avoid duplicate work if we send out a mail saying "I'll
now be working on part XXX" before we start writing.

> > -Layout of the .git directory
>
> Should we mention the metadata storage somewhere? This is probably
> too advanced for the tutorial but might be useful to have it in a
> development document (for other to understand where we keep things).

Yes, probably.

> Actually, is the automatically generated documentation from the new
> infrastructure enough?

I doubt it. It probably could be made enough, though, but I don't know
if that'd be better or worse than a separate document -- the code
documentation is tightly tied to the code, and I'm not sure if we want
that in this case.

We can let whoever writes it decide.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
