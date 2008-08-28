From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 28 Aug 2008 22:52:55 +0200
Message-ID: <20080828205255.GA28644@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080828140929.GB3584@khazad-dum.debian.net> <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	stgit@packages.debian.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:54:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoVW-0001Et-Mk
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbYH1Uwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbYH1Uwx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:52:53 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:49104 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162AbYH1Uww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:52:52 -0400
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 6C99D3F617C;
	Thu, 28 Aug 2008 22:52:51 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E998D3F6198;
	Thu, 28 Aug 2008 22:52:50 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D1F291F0C2; Thu, 28 Aug 2008 22:52:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94139>

On Thu, Aug 28, 2008 at 09:24:50PM +0200, Yann Dirson wrote:
> In except that lately I have not been very active on the stgit front
> (and on the debian front as well BTW)

Well, let's hope that will get me excused of writing bullshit :)

No, as you noticed, the packaging in stgit.git is not in sync with the
official package.  This ought to be fixed :).  I have started trying
to address that.

The official package ships a copy of documentation pages from the
wiki, because they contain information not otherwise available.  Do we
want to keep a copy of these files in the official repo ?
