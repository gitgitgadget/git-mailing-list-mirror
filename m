From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 15:18:56 -0700
Message-ID: <7vabyanqjz.fsf@assigned-by-dhcp.cox.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
	<7vr6rml4fb.fsf@assigned-by-dhcp.cox.net>
	<45FDB447.5070507@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 23:19:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3iN-00030B-QK
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbXCRWS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbXCRWS6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:18:58 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:39752 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964780AbXCRWS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:18:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318221857.PGYC18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 18:18:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cNJx1W0081kojtg0000000; Sun, 18 Mar 2007 18:18:57 -0400
In-Reply-To: <45FDB447.5070507@vilain.net> (Sam Vilain's message of "Mon, 19
	Mar 2007 09:51:03 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42537>

Sam Vilain <sam@vilain.net> writes:

> Junio C Hamano wrote:
> ...
> Maybe it's worth making it an error (that can be forced) if you're
> pushing to the head that's checked out in a non-bare repository ?

We talked about that in the past on the list.  No.
