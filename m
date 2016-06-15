From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Wed, 15 Jun 2016 20:15:56 +0000
Message-ID: <20160615201556.GA6303@dcvr.yhbt.net>
References: <20160612191550.GA14160@elvis.mu.org>
 <20160615051950.GA93388@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
To: Alfred Perlstein <alfred@freebsd.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 22:16:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDHEJ-0006DG-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 22:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbcFOUP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 16:15:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54246 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbcFOUP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 16:15:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30082018B;
	Wed, 15 Jun 2016 20:15:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160615051950.GA93388@elvis.mu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297396>

Alfred Perlstein <alfred@freebsd.org> wrote:
> Add example usage to the git-svn documentation.
> 
> Reported-by: Joseph Pecoraro <pecoraro@apple.com>
> Signed-off-by: Alfred Perlstein <alfred@freebsd.org> 
> ---
> 
> Junio, Pranit, + all,
> 
> A week ago I was requested to provide documentation for the
> 'svn propset' command.  I have attached a diff off of the
> 'maint' branch for this, however it seems to apply cleanly
> to 'master' as well.
> 
> Thank you for your patience.

Thanks Alfred,

I've removed the '.' from the commit subject, signed-off,
and pushed to my repo for Junio:

The following changes since commit 05219a1276341e72d8082d76b7f5ed394b7437a4:

  Git 2.9 (2016-06-13 10:42:13 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-propset-doc

for you to fetch changes up to f3961b2eba8ba6aa2fddc827ddf5c26b41391872:

  Document the 'svn propset' command (2016-06-15 20:11:22 +0000)

----------------------------------------------------------------
Alfred Perlstein (1):
      Document the 'svn propset' command

 Documentation/git-svn.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
