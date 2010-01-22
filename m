From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/1] Random documentation spelling fixes
Date: Fri, 22 Jan 2010 10:18:11 +0100
Message-ID: <4B596D53.7070108@drmicha.warpmail.net>
References: <1264126491-8273-1-git-send-email-vonbrand@inf.utfsm.cl> <1264126491-8273-2-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Jan 22 10:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYFgi-0001Ys-VW
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 10:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967Ab0AVJUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 04:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818Ab0AVJUO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 04:20:14 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36055 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752917Ab0AVJUM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 04:20:12 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F3742CE621;
	Fri, 22 Jan 2010 04:20:07 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 22 Jan 2010 04:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QXUiZ6FfY1CO1rTcaQHFSrXt3iQ=; b=TPdssKAR7Qd57KlUIGr6okb9E1IDW8YsR59VcsRJsjcSIvi/d6MpWVNWT4wUQOZ1zxHGbskc7qnoiNMcTntg2eqZK9oegq79htliPK5fiJXYDDEhCFm9TW2BWefdjz+34l+shqYHbPoJgYh7eSS6FcUri91dLOD9KA92IUxxRsQ=
X-Sasl-enc: jg1eYlHaLX8V/r0adP2EwnbiSa0xnBYpcBj8J4uOrO9D 1264152007
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EB9D04B9FA5;
	Fri, 22 Jan 2010 04:20:06 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100121 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <1264126491-8273-2-git-send-email-vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137749>

Horst H. von Brand venit, vidit, dixit 22.01.2010 03:14:
> Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
> ---
>  Documentation/RelNotes-1.5.0.txt       |    2 +-
>  Documentation/RelNotes-1.5.1.2.txt     |    2 +-
>  Documentation/RelNotes-1.5.1.4.txt     |    2 +-
>  Documentation/RelNotes-1.5.2.3.txt     |    2 +-
>  Documentation/RelNotes-1.5.2.txt       |    2 +-
>  Documentation/RelNotes-1.5.3.8.txt     |    2 +-
>  Documentation/RelNotes-1.5.3.txt       |    6 +++---
>  Documentation/RelNotes-1.5.4.2.txt     |    2 +-
>  Documentation/RelNotes-1.5.5.3.txt     |    2 +-
>  Documentation/RelNotes-1.5.6.txt       |    2 +-
>  Documentation/RelNotes-1.6.0.txt       |    4 ++--
>  Documentation/RelNotes-1.6.1.3.txt     |    2 +-
>  Documentation/RelNotes-1.6.3.txt       |    2 +-
>  Documentation/RelNotes-1.6.4.2.txt     |    2 +-
>  Documentation/RelNotes-1.6.4.3.txt     |    2 +-
>  Documentation/RelNotes-1.6.4.4.txt     |    2 +-
>  Documentation/RelNotes-1.6.4.txt       |    2 +-
>  Documentation/RelNotes-1.6.5.1.txt     |    2 +-
>  Documentation/RelNotes-1.6.5.3.txt     |    4 ++--
>  Documentation/RelNotes-1.6.5.4.txt     |    2 +-
>  Documentation/RelNotes-1.6.5.txt       |    2 +-
>  Documentation/RelNotes-1.6.6.txt       |    6 +++---

I don't think we should change release notes after the fact, should we?

>  Documentation/RelNotes-1.7.0.txt       |    2 +-
>  Documentation/config.txt               |    2 +-
>  Documentation/diff-format.txt          |    2 +-
>  Documentation/git-bisect-lk2009.txt    |    2 +-
>  Documentation/git-cvsimport.txt        |    4 ++--
>  Documentation/git-cvsserver.txt        |    2 +-
>  Documentation/git-fast-export.txt      |    2 +-
>  Documentation/git-filter-branch.txt    |    2 +-
>  Documentation/git-fsck.txt             |    4 ++--
>  Documentation/git-http-backend.txt     |    4 ++--
>  Documentation/git-imap-send.txt        |    4 ++--
>  Documentation/git-index-pack.txt       |    2 +-
>  Documentation/git-init.txt             |    2 +-
>  Documentation/git-ls-files.txt         |    2 +-
>  Documentation/git-merge-index.txt      |    2 +-
>  Documentation/git-mktree.txt           |    2 +-
>  Documentation/git-name-rev.txt         |    2 +-
>  Documentation/git-pack-objects.txt     |    2 +-
>  Documentation/git-patch-id.txt         |    2 +-
>  Documentation/git-receive-pack.txt     |    2 +-
>  Documentation/git-reflog.txt           |    4 ++--
>  Documentation/git-remote-helpers.txt   |    4 ++--
>  Documentation/git-remote.txt           |    2 +-
>  Documentation/git-repack.txt           |    2 +-
>  Documentation/git-replace.txt          |    4 ++--
>  Documentation/git-rev-parse.txt        |   10 +++++-----
>  Documentation/git-show-branch.txt      |    4 ++--
>  Documentation/git-show-index.txt       |    2 +-
>  Documentation/git-show-ref.txt         |    4 ++--
>  Documentation/git-submodule.txt        |    6 +++---
>  Documentation/git-svn.txt              |    8 ++++----
>  Documentation/git-tag.txt              |    2 +-
>  Documentation/git-unpack-file.txt      |    2 +-
>  Documentation/git-update-index.txt     |    4 ++--
>  Documentation/git-verify-tag.txt       |    2 +-
>  Documentation/git.txt                  |   12 ++++++------
>  Documentation/githooks.txt             |    2 +-
>  Documentation/gitk.txt                 |    2 +-
>  Documentation/gitmodules.txt           |    4 ++--
>  Documentation/gitrepository-layout.txt |    2 +-
>  Documentation/gittutorial-2.txt        |   16 ++++++++--------
>  Documentation/pretty-formats.txt       |    4 ++--
>  Documentation/user-manual.txt          |   14 +++++++-------
>  65 files changed, 110 insertions(+), 110 deletions(-)

That's not only many files changed in one patch, but also several
semi-automatic changes. We've had a discussion about SHA-1 vs. SHA1 vs.
sha1 a while ago. I don't think it led to a result, but looking that up
would be worthwhile.

Also, please have the commit message in the patch, not in a preceding
e-mail, and mention all types of changes, and split at least by category
(sha1 issue, protocol names, project names). Otherwise nobody will be
reviewing your patch, which would be sad: I favor consistency - and
failed several times in my attempts to reach it ;)

Michael
