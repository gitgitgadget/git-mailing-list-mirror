From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: t9155 fails against subversion 1.7.0
Date: Mon, 6 Feb 2012 22:59:00 +0000
Message-ID: <20120206225900.GA23830@dcvr.yhbt.net>
References: <op.v4neh4q20aolir@keputer>
 <op.v4pu1zcq0aolir@keputer>
 <robbat2-20120205T212444-523294742Z@orbis-terrarum.net>
 <CAH6sp9ORKvXt2_V4UgESTY7Tn2=9ysjWS3dO4eGgxCuZY1a5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:06:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuXds-0003ft-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 00:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab2BFXGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 18:06:30 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47868 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064Ab2BFXG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 18:06:28 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Feb 2012 18:06:27 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B6E1FEEC;
	Mon,  6 Feb 2012 22:59:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAH6sp9ORKvXt2_V4UgESTY7Tn2=9ysjWS3dO4eGgxCuZY1a5Yw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190118>

Frans Klaver <fransklaver@gmail.com> wrote:
> I haven't invested time in this, and the tests still seem to fail on
> subversion 1.7.x. Maybe one of the people involved in $gmane/184644
> knows more?

Not me.  I haven't had time/interest in dealing with SVN in a while.

I've always hoped somebody else has the time+interest for git-svn, but
given the self-obsoleting nature of git-svn, it's hard to find
motivation.
