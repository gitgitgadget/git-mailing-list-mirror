From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing
 submodule does not yield complete logs")
Date: Fri, 22 May 2015 11:42:58 +0200
Organization: gmx
Message-ID: <73db761f3c737965f64ac45005f7a716@www.dscho.org>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 11:43:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvjU0-0001Pu-Um
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 11:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992522AbbEVJnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 05:43:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:57286 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945919AbbEVJnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 05:43:04 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LymHf-1ZG6PU3wLH-0163lQ; Fri, 22 May 2015 11:43:00
 +0200
In-Reply-To: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:N8PbRSbb6C7bKIAqPSjBCV6axXAKJrtpyxyP+rV7HxVJaadJKSv
 G/U7TGS57LRKvuU4y7hc7bQDizGi4kcRFHkN3iDK8FiIKuoduRQC7auX/U0LJy6Hzwqovlf
 N4pb9U0qHm0SlAdTqSvJRqPlfBFnH11ea3l+SVpur5/M/+mc7EqXp6FNJn8SCVgiF4LhshF
 hx0kvQkhHWYAUNdUubZPw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269702>

Hi Roberto,

On 2015-05-22 10:33, Roberto Tyley wrote:
> On Tuesday, 19 May 2015, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, May 19, 2015 at 12:29 PM, Robert Dailey
>> <rcdailey.lists@gmail.com> wrote:
>> > How do you send your patches inline?
> [snip]
>> This workflow discussion was a topic at the GitMerge2015 conference,
>> and there are essentially 2 groups, those who know how to send email
>> and those who complain about it. A solution was agreed on by nearly all
>> of the contributors. It would be awesome to have a git-to-email proxy,
>> such that you could do a git push <proxy> master:refs/for/mailinglist
>> and this proxy would convert the push into sending patch series to the
>> mailing list. It could even convert the following discussion back into
>> comments (on Github?) but as a first step we'd want to try out a one
>> way proxy.
>>
>> Unfortunately nobody stepped up to actually do the work, yet :(
> 
> 
> Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
> one-way GitHub PR -> Mailing list tool, called submitGit:
> 
> https://submitgit.herokuapp.com/

Wow!!!

I will make sure to test it with a couple of patches I want to submit anyway.

Thanks so much!
Dscho
