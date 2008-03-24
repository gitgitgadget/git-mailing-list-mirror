From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: A script that keeps track of your favorite Git/SVN projects?
Date: Sun, 23 Mar 2008 21:04:06 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0803232051320.6107@dell.linuxdev.us.dell.com>
References: <fbede933c733.47e73470@broadpark.no>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1248610553-1206331446=:6107"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Kyrre_Nyg=E5rd?= <kyrreny@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Mar 24 05:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JddvZ-0002sC-2B
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 05:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbYCXEEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 00:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbYCXEEM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 00:04:12 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:39677 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbYCXEEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 00:04:11 -0400
Received: from sf.creativecommons.org (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id B8B77A0097;
	Mon, 24 Mar 2008 00:04:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by sf.creativecommons.org (Postfix) with ESMTP id C553F134CC41;
	Sun, 23 Mar 2008 21:04:06 -0700 (PDT)
X-X-Sender: paulproteus@dell.linuxdev.us.dell.com
In-Reply-To: <fbede933c733.47e73470@broadpark.no>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78001>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1248610553-1206331446=:6107
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 24 Mar 2008, "Kyrre Nygård" wrote:

> Hi there, Hasanybody ever written a script that keeps track of your 
> favorite Git(and SVN) projects? E.g. sends you an e-mail every time a 
> revision hasbeen made, with details like the summary, time and date, 
> author andcode differences.

I don't know of a "subscribe to a source repository" program myself, 
actually.

> I've modified a few projects to my liking, somuch that any change made 
> to the original would have to be addedmanually. I also think it would be 
> a great way to learn.

It does seem interesting!

> I can't imagine anything better than a neat little Ruby script stacked 
> inside my crontab. I'm still a rookie though, otherwise I'd have made my 
> own already.

The other thing you might do is run git-svn nightly, and have post-commit 
hook for git that emails out the diffs you like.

Whatever you do, keep me posted!

-- Asheesh.

-- 
I prefer rogues to imbeciles because they sometimes take a rest.
 		-- Alexandre Dumas, fils
--8323329-1248610553-1206331446=:6107--
