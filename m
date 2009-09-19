From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: SmartGit, a new GUI front-end for Git
Date: Sat, 19 Sep 2009 16:11:23 +0200
Message-ID: <4AB4E68B.70101@syntevo.com>
References: <4AB38D64.9010903@syntevo.com> <4AB48E25.8020504@syntevo.com> <e5e204700909190158y48b9c162ncea29f4b1635dc18@mail.gmail.com> <4AB4AA4A.4080801@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 19 16:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mp0eC-0003ZA-Vm
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 16:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbZISOKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 10:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755053AbZISOKQ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 10:10:16 -0400
Received: from syntevo.com ([85.214.39.145]:35698 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305AbZISOKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 10:10:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 41BA537CA4F
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AB4AA4A.4080801@syntevo.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128825>

Hi all,

The new build is uploaded. The ~/.gitconfig file now should be kept and on
Linux the splash screen hides before showing the initial dialog. Sorry for
any inconveniences.

--
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com


Thomas Singer wrote:
> Hi James,
> 
> Thanks for reporting this serious error. I will try to fix this in the next
> hour and upload a new build.
> 
> --
> Best regards,
> Thomas Singer
> =============
> syntevo GmbH
> http://www.syntevo.com
> http://blog.syntevo.com
> 
> 
> James Sadler wrote:
>> Hi Thomas,
>>
>> I just launched SmartGit, and it ate my ~/.gitconfig.  Luckily I had a
>> backup (full of my own aliases and colour settings etc.).
>>
>> SmartGit replaced mine with a ~/.gitconfig containing _only_ my name
>> and email settings.  Not good.  I would bet that 99% of all people on
>> this list have their own customized version of ~/.gitconfig and
>> SmartGit is probably going to eat it.  If it helps, I am running OS X.
>>
>> James.
>>
>> 2009/9/19 Thomas Singer <thomas.singer@syntevo.com>:
>>> Hi all,
>>>
>>> We would like to announce a new milestone build of our Git client "SmartGit"
>>> (don't be offended by the name, it's historically based) which we feel is
>>> ready now for a broader audience. SmartGit is quite stable and we want to
>>> invite everyone who is interested in giving it a try:
>>>
>>>  http://www.syntevo.com/smartgit/index.html
>>>
>>> Please don't expect all Git features and options implemented. We have
>>> tried to first concentrate on the most important ones - from our rather
>>> novice Git perspective.
>>>
>>> SmartGit runs on all operating systems which support a full Java 1.5
>>> implementation, including virtually all Linux versions, OS X 10.4 - 10.6 and
>>> Windows 2000 or newer. It requires a Git installation, although a couple of
>>> time-critical operations are handled by the JGit library.
>>>
>>> We appreciate your feed-back in our mailing list
>>>
>>>  http://www.syntevo.com/smartgit/community.html
>>>
>>> or directly to us (smartgit@syntevo.com). SmartGit 1.0 is planned to be
>>> released free of charge for non-commercial use or to active members of the
>>> Open Source community. Each pre-release build expires 3 months after the
>>> build-date.
>>>
>>> At this occasion I would also like to express my appreciation to the
>>> community for this great DVCS you have built. Approx. a 3/4 year ago I've
>>> started to use Git. Although I had some starting problems with it using the
>>> Git command line (mostly on Windows), I need to say that over time I really
>>> fell in love with Git and its elaborate foundations and feature set.
>>>
>>> --
>>> Best regards,
>>> Thomas Singer
>>> =============
>>> syntevo GmbH
>>> http://www.syntevo.com
>>> http://blog.syntevo.com
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
