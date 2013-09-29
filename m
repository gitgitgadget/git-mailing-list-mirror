From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3] build: add default aliases
Date: Sun, 29 Sep 2013 05:18:28 +0200
Message-ID: <52479C04.8060000@alum.mit.edu>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>	<20130924045325.GD2766@sigill.intra.peff.net>	<20130924183958.GK9464@google.com> <CAMP44s0UcP5AhWrm7vjBDLvY6CupzL03kys1YXs9cpGJNxkBBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 05:25:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ7da-0005rE-Ob
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 05:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab3I2DZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 23:25:35 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:60868 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753466Ab3I2DZd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Sep 2013 23:25:33 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Sep 2013 23:25:33 EDT
X-AuditID: 12074413-b7fc76d000002aba-0d-52479c078d06
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.A4.10938.70C97425; Sat, 28 Sep 2013 23:18:31 -0400 (EDT)
Received: from [192.168.69.9] (p57A25F5B.dip0.t-ipconnect.de [87.162.95.91])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8T3IStb032649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 28 Sep 2013 23:18:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAMP44s0UcP5AhWrm7vjBDLvY6CupzL03kys1YXs9cpGJNxkBBA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqMs+xz3IYP8GcYsNS9cwWxx8nGfR
	daWbyeLtzSWMFj9aepgdWD12zrrL7vGsdw+jx+dNcgHMUdw2SYklZcGZ6Xn6dgncGU9urGMs
	OCpcseDgSdYGxjP8XYycHBICJhITn2xlhrDFJC7cW8/WxcjFISRwmVHiyJ7rrBDOGSaJtvOf
	WUCqeAW0Je5f3MIOYrMIqEpMejyVDcRmE9CVWNTTzARiiwqESCxcdZwdol5Q4uTMJ2C9IgIJ
	EivnLAPbxiwQK3Hi71xGEFtYwEhi8eR1LBDLHjBKrJp3H2wop0CgxMzXh4EGcQA1qEusnycE
	0Ssvsf3tHOYJjAKzkKyYhVA1C0nVAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6
	qSmlmxgh4Sy8g3HXSblDjAIcjEo8vBFe7kFCrIllxZW5hxglOZiURHkdZwKF+JLyUyozEosz
	4otKc1KLDzFKcDArifB6TgPK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4
	OJQkeA1nAzUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI1vhgYqyApHqC95iDt
	vMUFiblAUYjWU4y6HE2bVn1lFGLJy89LlRLn5QApEgApyijNg1sBS16vGMWBPhbmfTcLqIoH
	mPjgJr0CWsIEtORWhRvIkpJEhJRUA6Pzp2OHWB45N4ty2ipvDugSPMIUHsS0+OHkt/0yh1c9
	3yi0euUW4VnLfjAydDTliv8QLpj7Idu20Fr5kjvX50UZiy3uTpiukCZgfG35+haG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235575>

On 09/29/2013 12:41 AM, Felipe Contreras wrote:
> On Tue, Sep 24, 2013 at 1:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> On Sat, Sep 21, 2013 at 02:20:21PM -0500, Felipe Contreras wrote:
>>>> For now simply add a few common aliases.
>>>>
>>>>   co = checkout
>>>>   ci = commit
>>>>   rb = rebase
>>>>   st = status
>>>
>>> [...]
> 
>> But making 'ci' a synonym of another command by default while still
>> keeping its definition configurable would be doing people a
>> disservice, I fear.
> 
> And I and many (most) users disagree.
> 
>> As long as 'ci' works out of the box, it will
>> start showing up in examples and used in suggestions over IRC, etc,
>> which is great.

...and in scripts.

> It might, or...
> 
>> Unfortunately that means that anyone who has 'ci'
>> defined to mean something different can no longer use those examples,
>> that advice from IRC, and so on.  So in the world where 'ci' is a
>> synonym for 'commit' by default, while people still *can* redefine
>> 'ci' to include whatever options they like (e.g., "-a"), actually
>> carrying out such a personal customization is asking for trouble.
> 
> Precisely for this reason it might not. If people know aliases can be
> different in different machines, they would avoid them in
> documentation which is meant for all machines.

My experience contradicts your prediction.  I have 'ci'/'co' aliases in
my own configuration.  But even though I am aware of the fact that other
people might not have the same aliases, I have on multiple occasions
used them in documentation and/or scripts meant for other people.  The
muscle memory is just too strong.

My error was discovered by other people who didn't have those aliases.
If *most* people had the same aliases as I did, and others had defined
their own slightly different ones, then the scripts would have subtly
malfunctioned for the latter set of users and I would have had trouble
reproducing the errors.

That being said, independent of aliases, there are many other config
settings that can affect commands that might be used in documentation or
scripts, and which also could be the source of errors for the non-vigilent.

So, even though I think such aliases are a great convenience factor, I
am -0 on including pre-defined but overrideable aliases and -1 on
including pre-defined and non-overrideable aliases.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
