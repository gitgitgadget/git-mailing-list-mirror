From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Request for help
Date: Wed, 2 Sep 2009 18:23:15 -0700
Message-ID: <20090903012315.GG1033@spearce.org>
References: <4A9EFFB1.9090501@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 03:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj12o-0007Ne-1A
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 03:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbZICBXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 21:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbZICBXN
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 21:23:13 -0400
Received: from george.spearce.org ([209.20.77.23]:40038 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbZICBXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 21:23:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 52BE5381FD; Thu,  3 Sep 2009 01:23:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A9EFFB1.9090501@codeaurora.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127637>

Nasser Grainawi <nasser@codeaurora.org> wrote:
> Should PatchId be a class on its own, or just a method within the Patch  
> class?

Hmm, maybe a method on Patch is reasonable.

-- 
Shawn.
