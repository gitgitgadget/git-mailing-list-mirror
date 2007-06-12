From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Unquote From line from patch before comparing with given from address.
Date: Mon, 11 Jun 2007 22:28:13 -0700
Message-ID: <7v4pldn3ma.fsf@assigned-by-dhcp.pobox.com>
References: <11815814802456-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 07:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxyvb-0007lT-4X
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 07:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbXFLF2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 01:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbXFLF2Q
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 01:28:16 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61702 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbXFLF2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 01:28:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612052815.XJXX6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 01:28:15 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AVUE1X00B1kojtg0000000; Tue, 12 Jun 2007 01:28:15 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49920>

Thanks.

That has been longstanding, and I hinted how that can be fixed a
couple of times on the list, and was waiting for somebody for
whom fixing it would make a difference to fix it, while sort of
pretending to be lazy.

Happy to see finally somebody stepped forward ;-).
