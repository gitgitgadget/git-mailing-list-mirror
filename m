From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: gitk-1.0 released
Date: Fri, 20 May 2005 09:13:41 +1000
Message-ID: <1116544421.5153.46.camel@gaston>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 02:00:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYuvK-00083f-Ox
	for gcvg-git@gmane.org; Fri, 20 May 2005 01:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVESX76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 19:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVESXSE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 19:18:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:32671 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261348AbVESXO5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 19:14:57 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j4JN7sZn003186;
	Thu, 19 May 2005 18:07:55 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-19 at 23:05 +1000, Paul Mackerras wrote:
> I have released a new version of gitk.  I got brave and called it 1.0
> and it is at:
> 
> 	http://ozlabs.org/~paulus/gitk-1.0
> 
> (that's the actual script itself).
> 
> Gitk is a git commit viewer with the following features:
> 
> * Clear and compact representation of the commit graph
> * Displays headline, author and date of each commit in the
>   summary window
> * Displays the full details of one commit - the comments,
>   list of files and colorized diff - in the details window
> * Find function for searching through commits
> * Displays the SHA1 ID of the selected commit and makes it
>   the X selection so it can be pasted into other windows
> * Convenient key bindings for scanning through each commit
>   in turn

Cool !

Here's a feature request though: beeing able to type/paste a SHA1 in the
SHA1 ID field to "jump" to that commit :)

Ben.


