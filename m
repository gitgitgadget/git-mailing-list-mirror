From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Wed, 21 Dec 2005 14:34:11 -0800
Message-ID: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 21 23:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpCXK-0006qj-HJ
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 23:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVLUWeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 17:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVLUWeO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 17:34:14 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15502 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751186AbVLUWeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 17:34:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221223213.BQCO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 17:32:13 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13908>

I've pushed out a v1.0.0b maint release to fix a bug in HTTP
fetch that was discovered today X-<.
