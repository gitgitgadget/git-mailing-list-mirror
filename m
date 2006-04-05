From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: document --append
Date: Wed, 05 Apr 2006 12:34:05 -0700
Message-ID: <7vfykr24wi.fsf@assigned-by-dhcp.cox.net>
References: <20060405191608.GA20572@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 21:34:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRDlc-0003YQ-EF
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 21:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWDETeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWDETeI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 15:34:08 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48037 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932072AbWDETeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 15:34:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405193406.NCNN26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 15:34:06 -0400
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060405191608.GA20572@fiberbit.xs4all.nl> (Marco Roeland's
	message of "Wed, 5 Apr 2006 21:16:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18449>

Thanks for resurrecting this.

I suspect that some formatting tweak is needed; I recall
asciidoc needs some special formatting when multi- paragraph
description is involved in the list.

Of course, munging the patch title with s/append/amend/ would
not hurt ;-).
