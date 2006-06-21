From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix possible out-of-bounds array access
Date: Wed, 21 Jun 2006 04:01:24 -0700
Message-ID: <7vfyhy22nv.fsf@assigned-by-dhcp.cox.net>
References: <20060620160836.GA20153@informatik.uni-freiburg.de>
	<20060621090412.GA9267@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 13:01:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0Sf-00006e-Lz
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 13:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWFULB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 07:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFULB0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 07:01:26 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52154 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751488AbWFULBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 07:01:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621110125.CBFX12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 07:01:25 -0400
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22258>

Thanks.
