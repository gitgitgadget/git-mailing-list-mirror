From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk strangeness..
Date: Tue, 28 Mar 2006 22:41:00 -0800
Message-ID: <7vfyl1bvnn.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	<7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
	<17448.54558.865097.519248@cargo.ozlabs.ibm.com>
	<7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
	<17449.48630.370867.10251@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 08:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOUMq-0005jG-Sa
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 08:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWC2GlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 01:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWC2GlI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 01:41:08 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:2503 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750818AbWC2GlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 01:41:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329064106.CUOJ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Mar 2006 01:41:06 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17449.48630.370867.10251@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 29 Mar 2006 09:51:34 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18159>

Paul Mackerras <paulus@samba.org> writes:

> That's brilliant.  Thank you!  With the patch to gitk below, the
> graph display on Linus' example looks much saner.

Indeed this looks much saner.  Thanks.
