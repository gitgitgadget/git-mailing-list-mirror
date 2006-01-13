From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: Add -A <author-conv-file> option
Date: Thu, 12 Jan 2006 17:55:03 -0800
Message-ID: <7vvewohoy0.fsf@assigned-by-dhcp.cox.net>
References: <20060112233859.3438F5BED0@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 02:55:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExE9q-0004Uj-70
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 02:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161635AbWAMBzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 20:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161636AbWAMBzH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 20:55:07 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58101 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161635AbWAMBzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 20:55:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113015509.BFUH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 20:55:09 -0500
To: exon@op5.se (Andreas Ericsson)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14598>

ISTR there was a thread that suggested using CVSROOT/users file
for this purpose.

	http://thread.gmane.org/gmane.comp.version-control.git/8167
