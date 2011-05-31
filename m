From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id)
 in notes
Date: Mon, 30 May 2011 21:53:24 -0700
Message-ID: <20110531045324.GA13661@dcvr.yhbt.net>
References: <201105281154.25223.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 06:53:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRGxS-0006NZ-S1
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 06:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab1EaEx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 00:53:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38590 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab1EaEx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 00:53:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905C1212C7;
	Tue, 31 May 2011 04:53:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201105281154.25223.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174790>

Jakub Narebski <jnareb@gmail.com> wrote:
> Eric, from what I remember you don't have time nor inclination for 
> adding new features to git-svn, is it?

Yes, that's mostly the case.  I suggest anybody interested in working on
git-svn further to split out the Perl modules into separate files before
doing any more work on it.

-- 
Eric Wong
