From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 12:16:10 -0700
Message-ID: <4FA2D97A.8090504@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>	<4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com>	<86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com>	<86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com>	<86aa1rmvhb.fsf@red.stonehenge.com> <4FA05E9F.9090709@palm.com> <CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com> <4FA2D1D7.3020807@palm.com> <CA+7g9JzZ36RgsniT4UN0Zk+z1ohZYW5u+0AoGMjJZqsoBjqvqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Thu May 03 21:16:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1Vg-000352-G9
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176Ab2ECTQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:16:12 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:58467 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab2ECTQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:16:11 -0400
X-IronPort-AV: E=Sophos;i="4.75,526,1330934400"; 
   d="scan'208";a="13294914"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 03 May 2012 12:16:11 -0700
Received: from fuji.noir.com ([10.100.2.12])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q43JGA2I001171;
	Thu, 3 May 2012 12:16:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CA+7g9JzZ36RgsniT4UN0Zk+z1ohZYW5u+0AoGMjJZqsoBjqvqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196946>

On 5/3/12 12:09 , Nathan Gray wrote:
> On Thu, May 3, 2012 at 11:43 AM, Rich Pixley<rich.pixley@palm.com>  wrote:
>> In hg, I don't have to think about how many other branches or repositories
>> there might be.  I don't have to track where the changes are.  And I don't
>> have to do anything to add another repository to the mix or to remove one.
>>   Trivial merges are trivial.  The view from any repository is identical, not
>> just symmetric.  The things I want to do are all simple commands.  Pull from
>> the cache, merge if necessary, do some work, push to the cache.  Repeat as
>> necessary since there will be numerous collisions and merges since I'm
>> working on multiple machines concurrently.  And eventually, push to central
>> server.
> Wow, this hg sounds great!  You should use that!
>
> All kidding aside, what you're talking about are design decisions
> based on preferred workflows.  The workflow you're describing may seem
> obvious and fantastic to you, but it sounds absurdly complicated to
> me.  You hate the way git handles remote branches.  I think it's
> incredibly sensible for a *truly* distributed VCS to enforce
> location-based namespacing.  Basically, we have differences of
> opinion.  Since your opinion seems to be that hg has done everything
> right and git has done everything wrong, why are you using git?
Corporate mandate.  Political decision made without discussion with the 
people who would be using it.

--rich
