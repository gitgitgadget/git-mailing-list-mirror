From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Remove useless uses of cat, and replace with filename arguments or redirection
Date: Wed, 06 Jun 2007 19:52:33 -0700
Message-ID: <7vtztkqxvy.fsf@assigned-by-dhcp.cox.net>
References: <466639D0.1040306@freedesktop.org>
	<7vsl94sego.fsf@assigned-by-dhcp.cox.net>
	<46676C35.60406@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 04:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw87E-000611-N4
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbXFGCwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbXFGCwf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:52:35 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56382 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbXFGCwf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:52:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607025234.QHHC29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 22:52:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8SsZ1X00d1kojtg0000000; Wed, 06 Jun 2007 22:52:34 -0400
In-Reply-To: <46676C35.60406@freedesktop.org> (Josh Triplett's message of
	"Wed, 06 Jun 2007 19:23:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49344>

Josh Triplett <josh@freedesktop.org> writes:

> No, just fixed differently. :) Note the change to the tr invocation: delete
> everything other than digits.

Ah, silly me.  Sorry for the noise.
