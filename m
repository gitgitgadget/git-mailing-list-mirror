From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 0/7] Series short description
Date: Sat, 27 Jan 2007 18:17:05 +0100
Message-ID: <20070127171705.GH4083@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070127170204.25975.82477.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArC3-0000KM-Qc
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbXA0RSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbXA0RSU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:18:20 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:53019 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbXA0RSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:18:20 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 258A855CB;
	Sat, 27 Jan 2007 18:18:19 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id CD2B71F08A; Sat, 27 Jan 2007 18:17:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070127170204.25975.82477.stgit@gandelf.nowhere.earth>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37966>

Sorry for this mail (and the similar from yesterday).  It looks like
"stg mail" needs to be fixed so one can abort a send.  Currently, when
I try to interrupt it with Ctrl-C, it looks as if it was indeed the
editor (gnuclient) which gets terminated, and "stg mail" proceeeds
with the send, at least to some point.

Best regards,
-- 
Yann.
