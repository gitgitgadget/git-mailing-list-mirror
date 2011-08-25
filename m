From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: One MMORPG git facts
Date: Thu, 25 Aug 2011 00:57:07 -0700
Message-ID: <4E560053.1080005@eaglescrag.net>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com> <loom.20110825T081519-218@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Thu Aug 25 09:57:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwUox-0001Gx-RW
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 09:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab1HYH5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 03:57:45 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:41805 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1HYH5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 03:57:45 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p7P7v7qk020568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 25 Aug 2011 00:57:08 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <loom.20110825T081519-218@post.gmane.org>
X-Enigmail-Version: 1.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Thu, 25 Aug 2011 00:57:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180065>

On 08/24/2011 11:53 PM, Marat Radchenko wrote:
> Lawrence Brett <lcbrett <at> gmail.com> writes:
> 
>>
>> Hello,
>>
>> I am very interested in using git for game development.  I will be working
>> with a lot of binaries (textures, 3d assets, etc.) in addition to source
>> files.  I'd like to be able to version these files, but I understand that
>> big binaries aren't git's forte.
> 
> Define "big".
> 
> I have one MMORPG here under Git. 250k revisions, 500k files in working dir
> (7Gb), 200 commits daily, 250Gb Git repo, SVN upstream repo of ~1Tb.

Given the differences, I'm morbidly curious, which actually ends up
being the more usable version control system of a project of this scale?
 It sounds like (from what you've said) git is generally faster,
assuming it can get enough resources (which can obviously be hard at the
scales your talking).

- John 'Warthog9' Hawley
