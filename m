From: jamespetts <jamespetts@yahoo.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
  SVN
Date: Sun, 29 Mar 2009 03:51:16 -0700 (PDT)
Message-ID: <1238323876827-2552153.post@n2.nabble.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> <1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> <1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> <1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> <1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 12:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnsdJ-0003w6-JO
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 12:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbZC2KvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 06:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbZC2KvW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 06:51:22 -0400
Received: from kuber.nabble.com ([216.139.236.158]:47928 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZC2KvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 06:51:21 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1Lnsbk-0002kQ-Qt
	for git@vger.kernel.org; Sun, 29 Mar 2009 03:51:16 -0700
In-Reply-To: <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com>
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115015>


Thank you for your reply :-) I updated, and was able to get the git svn command to work, using the syntax described in a previous post.

However, after several hours of downloading (I left it overnight), it gave the error, "The connection was aborted: Can't read from connection: The connection was aborted at C:\Program Files\Git/libexec/git-core/git-svn/ line 2490".

When I look at my repository on Github, it is still empty, apart from the empty README file that I created just to initialise it. Why would it be going wrong? How do I deal with that?


Heya,

On Sat, Mar 28, 2009 at 23:18, jamespetts <jamespetts@yahoo.com> wrote:
> git: 'svn' is not a git-command. See 'git --help'.

Try updating to the latest snapshot, git shipped without svn on
windows for a few releases.

-- 
Cheers,

Sverre Rabbelier
--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
View this message in context: http://n2.nabble.com/Fork-of-abandoned-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2552153.html
Sent from the git mailing list archive at Nabble.com.
