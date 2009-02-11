From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: showing SHA1 of parent commit in tig [was Re: [ANNOUNCE] tig-0.14
Date: Wed, 11 Feb 2009 16:05:40 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp5tqk.u46.sitaramc@sitaramc.homelinux.net>
References: <20090205204436.GA6072@diku.dk> <20090206104946.GE7259@b2j>
 <2c6b72b30902060629i2539ddds48ab858e83d4bb4@mail.gmail.com>
 <slrngooljv.urh.sitaramc@sitaramc.homelinux.net>
 <2c6b72b30902080207m4a1e14b7j4862f9a8b7ca32a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 17:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHcW-00063B-6L
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbZBKQGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755860AbZBKQGA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:06:00 -0500
Received: from main.gmane.org ([80.91.229.2]:46727 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbZBKQF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:05:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LXHb0-0004ux-B9
	for git@vger.kernel.org; Wed, 11 Feb 2009 16:05:54 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 16:05:54 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 16:05:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109432>

On 2009-02-08, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Fri, Feb 6, 2009 at 16:25, Sitaram Chamarty <sitaramc@gmail.com> wrote:

>> But I must say that the last time I did this, the hunks that
>> tig showed me were more granular than what 'git gui' did; no
>> idea why.  To do what I wanted to do in 'git gui' was
>> possible, by staging line by line instead of hunk by hunk,
>> but I didn't fancy all that clicking and tig saved me.

> Great to hear. I sometimes, miss though, being able to lower the diff
> context to 1 or 2, however, maybe I should learn to commit more often
> instead.

Is there any way to see the sha1 of the parent commit in any
of the displays, like gitk does?

I know you're only parsing the 4 or 5 basic git commands,
and none of those do, so I guess I know the answer :-( but
it doesn't hurt to ask.
