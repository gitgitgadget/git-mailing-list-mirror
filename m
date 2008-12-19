From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit doesn't support "compare with" and "replace with"?
Date: Fri, 19 Dec 2008 07:20:45 -0800
Message-ID: <20081219152045.GR32487@spearce.org>
References: <1229677848765-1677009.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin_S <iksdrijf@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 16:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDhAz-0006ZA-3d
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 16:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYLSPUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 10:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbYLSPUq
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 10:20:46 -0500
Received: from george.spearce.org ([209.20.77.23]:39982 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYLSPUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 10:20:46 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8C1A038200; Fri, 19 Dec 2008 15:20:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229677848765-1677009.post@n2.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103565>

Martin_S <iksdrijf@yahoo.com> wrote:
> 
> Hi, I'm using eclipse 3.4 and jgit 0.4. The right click context menus don't
> list "compare with" and "replace with". Am I doing something wrong?

We haven't implemented them in EGit.  So its not surprising that
they aren't appearing.

-- 
Shawn.
