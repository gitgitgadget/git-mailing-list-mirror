From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH 0/9] Refactoring of command handling
Date: Wed, 20 Jun 2007 00:41:17 +0200
Message-ID: <20070619224116.GB7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0mO1-0006Sq-LU
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 00:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbXFSWlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 18:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbXFSWlU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 18:41:20 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48391 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704AbXFSWlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 18:41:19 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E7179783D;
	Wed, 20 Jun 2007 00:41:18 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1843C1F150; Wed, 20 Jun 2007 00:41:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50518>

On Sun, Jun 17, 2007 at 12:00:28AM +0200, Yann Dirson wrote:
>       Refactor command definition with a Command class.

That patch (3/9, and the main patch in the series) was most probably
blocked from the list because of its size.  The whole series is anyway
available at http://repo.or.cz/w/stgit/ydirson.git (together with even
more unreleased patches - beware ;)

More generally, I'll try to --sign those patches in my stack that I
consider stable and have been (or are in the queue fo being) sent to
Catalin.

Best regards,
-- 
Yann
