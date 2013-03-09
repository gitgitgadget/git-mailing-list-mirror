From: Robin Green <greenrd@greenrd.org>
Subject: [ANNOUNCE] TopGit 0.9
Date: Sat, 09 Mar 2013 14:27:13 +0000
Message-ID: <d9e0422338aa163eca1e87bca3bd2859@greenrd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 15:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEL2g-000709-0Q
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 15:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579Ab3CIOqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 09:46:07 -0500
Received: from mail.dnsexit.com ([67.214.171.68]:48036 "EHLO mail.dnsexit.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757736Ab3CIOqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 09:46:06 -0500
X-Greylist: delayed 1148 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2013 09:46:06 EST
Received: from webmail.dnsexit.com (webmail [67.214.161.144])
	by mail.dnsexit.com (Postfix) with ESMTP id 8C3EE8B5D21
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 09:26:44 -0500 (EST)
X-Sender: greenrd@greenrd.org
User-Agent: Roundcube Webmail/0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217727>

Hello,

I'm pleased to announce that TopGit 0.9 was released today.

TopGit aims to make handling of large amounts of interdependent topic
branches easier. In fact, it is designed especially for the case where
you maintain a queue of third-party patches on top of another (perhaps
Git-controlled) project and want to easily organize, maintain and 
submit
them - TopGit achieves that by keeping a separate topic branch for each
patch and providing some tools to maintain the branches.

After a long hiatus, TopGit has a new release, a new maintainer (me), 
and
has moved to GitHub:

   https://github.com/greenrd/topgit

(note that patches are still required to be signed off.)

The 0.9 release is tagged and available for download at: 
https://github.com/greenrd/topgit/tags
(Yes, I know GitHub's display of the tag description is terrible, but 
it
shows up fine in git.)

Because it's been 3 years since the last release, there are quite a few
patches since 0.8, but most of them are quite minor changes.

If you are upgrading from the HEAD of the old TopGit repository, all of 
and
only the patches by me, Andrey Borzenkov and Heiko Hund are new 
compared to
that revision.

Patches can be submitted either to me, to this list, or to the GitHub
issue tracker. There is also an IRC channel, #topgit on 
irc.freenode.net.

Regards,
Robin Green
