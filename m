From: Pavel Roskin <proski@gnu.org>
Subject: Re: cg-pull to pull branches, not the whole repository
Date: Thu, 15 Sep 2005 23:09:41 -0400
Message-ID: <1126840181.2387.8.camel@dv>
References: <1126733516.10827.54.camel@dv>
	 <7vu0gne25j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 05:10:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG6br-0003aQ-Nj
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 05:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbVIPDJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 23:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030579AbVIPDJx
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 23:09:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:64716 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030577AbVIPDJw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 23:09:52 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EG6bi-000266-Bl
	for git@vger.kernel.org; Thu, 15 Sep 2005 23:09:49 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EG6bd-00010p-KK; Thu, 15 Sep 2005 23:09:41 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0gne25j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8658>

On Wed, 2005-09-14 at 15:05 -0700, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > ...  Unfortunately, listings are
> > still needed to get refs/tags and refs/heads.  Any fix for that would
> > involve git core, and I don't see an elegant fix.
> 
> All the necessary "core" support should already be there, except
> for the client side support.  Please look at yesterday's thread
> with title "dumb transports not being welcomed".

Great.  It looks like my concerns are fully understood and the work is
underway to address them.  Sorry for the noise.

-- 
Regards,
Pavel Roskin
