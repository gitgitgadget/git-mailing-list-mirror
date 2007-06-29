From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: force checkout of working tree after initial import
Date: Thu, 28 Jun 2007 21:41:08 -0700
Message-ID: <7vhcorid97.fsf@assigned-by-dhcp.pobox.com>
References: <20070628111207.28276.qmail@a0ecab5969a5b1.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 06:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I48ID-0005eE-PV
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 06:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXF2ElL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 00:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXF2ElL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 00:41:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62281 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbXF2ElK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 00:41:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629044110.MVCD1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 00:41:10 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HGh81X00H1kojtg0000000; Fri, 29 Jun 2007 00:41:09 -0400
In-Reply-To: <20070628111207.28276.qmail@a0ecab5969a5b1.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Thu, 28 Jun 2007 11:12:07 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51147>

Thanks.
