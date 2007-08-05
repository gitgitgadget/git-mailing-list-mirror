From: Junio C Hamano <gitster@pobox.com>
Subject: Re: way to automatically add untracked files?
Date: Sat, 04 Aug 2007 21:13:28 -0700
Message-ID: <7vhcneipp3.fsf@assigned-by-dhcp.cox.net>
References: <873ayymzc1.fsf@catnip.gol.com>
	<20070805035854.GF9527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 06:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXUl-000728-9e
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXHEENb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbXHEENb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:13:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46254 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbXHEEN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:13:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805041329.GYFV14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 00:13:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y4DV1X0021kojtg0000000; Sun, 05 Aug 2007 00:13:29 -0400
In-Reply-To: <20070805035854.GF9527@spearce.org> (Shawn O. Pearce's message of
	"Sat, 4 Aug 2007 23:58:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54935>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I believe this has been fixed in git 1.5.3-rc3 or rc4.

That performance fix is in rc4.
