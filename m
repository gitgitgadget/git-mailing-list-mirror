From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 14:57:58 -0700
Message-ID: <4FA05C66.2060608@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com> <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com> <86ipgfmw05.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:58:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPL5j-0001RL-T6
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab2EAV6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:58:01 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:63043 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2EAV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:58:00 -0400
X-IronPort-AV: E=Sophos;i="4.75,513,1330934400"; 
   d="scan'208";a="13249902"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 14:58:00 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q41Lvwd0032083;
	Tue, 1 May 2012 14:57:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <86ipgfmw05.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196759>

On 5/1/12 14:28 , Randal L. Schwartz wrote:
>>>>>> "Rich" == Rich Pixley<rich.pixley@palm.com>  writes:
>
> Rich>  I think we have different definitions of "easily".  This is
> Rich>  simple, first use sorts of stuff.
>
> Have you read the Pro Git book?

Yes.  The things it covers, it mostly covers well.  But it's lacking a lot.

There's nothing in it about repository networks, how to get stuff out of 
my index, reset, and it's not very good about explaining that things 
like rebase screw up your repository in ways that make sharing 
impossible.  I know that because of how mercurial works and from reverse 
engineering what must be required, not from reading git doc.

And I've spent close to a week now trying to use git on this project, 
throwing away repositories, patching by hand, and trying to sort out why 
git was refusing to push for me.  That wasn't explained at all nor do 
the git error messages explain what's happening.

> Have you read the gitcore-tutorial page?

Not recently.  It was pretty much impenetrable the first few times 
through.  I was looking for how to use git, I wasn't interested in all 
of the gory details of how it stored everything.

Just skimmed again.  Will need to read it again more thoroughly, though 
I don't see anything on the stuff we've been discussing.

> Have you read the gitworkflows manpage?

Yes, but not in a long time.  It seems to be more about the policies of 
working on git source code than about usage of git.

> The processes for "simple, first use" sorts of stuff never gets into
> the complexity you are describing.  You're definitely into more advanced
> stuff and then complain when you also need to be more advanced to set it
> up.  Not sure what your goal is, then.

This stuff isn't advanced anymore.  It's kind of standard.  My complaint 
is that doing standard stuff like this shouldn't require advanced work.

I have days, weeks into git learning curve so far, I've clearly only 
begun, and I have a big list of things I still can't do in git, though I 
can do them in other source code control systems.  In contrast, I was up 
and using mercurial in about a day and a half, including all of the 
stuff we've discussed, and all of the things I've even read about in 
git.  Learning mq's only took about 20 minutes.

--rich
