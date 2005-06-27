From: Paul Mackerras <paulus@samba.org>
Subject: Re: new features in gitk
Date: Tue, 28 Jun 2005 09:36:40 +1000
Message-ID: <17088.36232.479492.643878@cargo.ozlabs.ibm.com>
References: <17088.31798.17291.605567@cargo.ozlabs.ibm.com>
	<42C08265.2050209@looxix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 01:36:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn39W-0002PY-FA
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 01:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVF0XkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 19:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVF0XiU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 19:38:20 -0400
Received: from ozlabs.org ([203.10.76.45]:54477 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262096AbVF0Xgs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 19:36:48 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B4DBE67A79; Tue, 28 Jun 2005 09:36:46 +1000 (EST)
To: Luc Van Oostenryck <lkml@looxix.net>
In-Reply-To: <42C08265.2050209@looxix.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Luc Van Oostenryck writes:

> I find the patch generation very usefull (when I've seen the tool a few days ago, I've said to myself:
> "what a wonderfull tool, if only I could create a patch from this")
> but it doesn't work for me (the first three entries stay always in grey, only the last one "Create tag" is in black).
> I'm missing something ?

The diffs and patches are between the selected commit (one that you
clicked on with the left button and which is shown with a grey
background) and the commit where you click the right button.  That was
the best way I could think of to indicate which were the two commits
to diff.  If you (or anyone) has a better suggestion, let me know.

Paul.
