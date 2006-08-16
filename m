From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make inline is_null_sha1 global
Date: Tue, 15 Aug 2006 23:40:50 -0700
Message-ID: <7vlkpp41zh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608151335020.1475@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Aug 16 08:41:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDF5F-0001uQ-0f
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 08:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWHPGkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 02:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWHPGkw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 02:40:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51703 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750855AbWHPGkv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 02:40:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060816064051.YKLL6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 02:40:51 -0400
To: David Rientjes <rientjes@google.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25503>

Makes sense, except the gotcha found by Jonas.
Thanks, both.

BTW, please drop the "\n\t\tDavid\n" from these messages and
fold lines to a reasonable length.
