From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Newbie grief
Date: Wed, 2 May 2012 00:55:24 +0100
Organization: OPDS
Message-ID: <5ADB8D763B2B4CDA889052A1AA45F089@PhilipOakley>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com> <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com> <86ipgfmw05.fsf@red.stonehenge.com> <4FA05C66.2060608@palm.com> <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Sitaram Chamarty" <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, "Seth Robertson" <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: "Michael Witten" <mfwitten@gmail.com>,
	"Rich Pixley" <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 01:55:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPMuM-00066X-SB
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 01:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab2EAXy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 19:54:57 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:54517 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752514Ab2EAXy5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 19:54:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AncFAG53oE9cGnaI/2dsb2JhbABEhWmFSKRKgwCBCIIEAQQBAQUIAQEZFR4BARUMCwIDBQIBAw4HAQICAgUhAgIUAQQIEgYHFwYBEggCAQIDAYU3B4IoCAMPB6dSiE4NiVOBL4hYhWo1YwSNeokVii6FA4Jp
X-IronPort-AV: E=Sophos;i="4.75,514,1330905600"; 
   d="scan'208";a="389675620"
Received: from host-92-26-118-136.as13285.net (HELO PhilipOakley) ([92.26.118.136])
  by out1.ip01ir2.opaltelecom.net with SMTP; 02 May 2012 00:54:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196771>

From: "Michael Witten" <mfwitten@gmail.com> Sent: Tuesday, May 01, 2012 
11:56 PM
> On Tue, May 1, 2012 at 9:57 PM, Rich Pixley <rich.pixley@palm.com> wrote:
>
>> In contrast, I was up and using mercurial in about a day and a half,
>> including all of the stuff we've discussed, and all of the things I've 
>> even
>> read about in git. Learning mq's only took about 20 minutes.
>
> Fortunately, git is based on extremely simple principles.
> Unfortunately, git grew out of really bright people hacking stuff
> together in order to get sh!t dun; the result is not approachably or
> even well documented, the UI is sometimes a bit of a kludge, the API
> is probably nonexistent, and the terminology is so loosely thrown
> about that it's easy to forget which way is up in discussions.
> (Note, though, that Junio has done a laudable job of keeping the
> whole experiment going strong).
>
> Having recognized these deficiencies, I suggest that you provide
> at least one tiny little use case that doesn't work as you'd
> like; it should be in the form of a command line example that we
> can all reproduce and discuss precisely.
> --
A bit of browsing found 
http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial/ which 
helped with some of the confusion about the different meanings of "branch". 
It looks like an Hg branch is a Git clone.  Git can be hard work until one 
'gets' how and why the new DVCS approach works. Plus learing the UI.

It is very hard to change one's mindset about how/why/when the old VCS 
approach broke (or isn't). The common VCS approach is based on drawing 
office practices from before the Titanic was built. It is only very recently 
that the reproduction and verification cost for data duplication have 
dropped sufficiently that a DVCS is the better approach. The historical 
approach was to protect the single 'master' item (with lots of admin & 
process). Now it's about 'status accounting' - do I have the right copy at 
the right status - i.e. the declared master sha1.

Philip 
