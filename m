From: "Alfred M. Szmidt" <ams@gnu.org>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Wed, 17 Jun 2009 18:27:19 -0400
Message-ID: <E1MH3bD-0004fq-07@fencepost.gnu.org>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
Reply-To: ams@gnu.org
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH3bN-0007xD-Py
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 00:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759024AbZFQW1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756315AbZFQW1S
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 18:27:18 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:48908 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097AbZFQW1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 18:27:17 -0400
Received: from ams by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <ams@gnu.org>)
	id 1MH3bD-0004fq-07; Wed, 17 Jun 2009 18:27:19 -0400
In-reply-to: <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
	(message from Linus Torvalds on Sun, 14 Jun 2009 21:25:34 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121781>

   Side note: for somebody with a "gnu.org" address, you're showing
   some really bad taste. Do you know that the FSF ends up asking for
   a hell of a lot of paperwork and other crazy things to take peoples
   submissions. And they actually want the copyrights signed over, so
   that they can change it to _any_ license.

   The DCO, in contrast, is a paragon of simplicity and clarity, and
   doesn't ask you to sign away any rights.

You are misinformed.  The copyright assignments from the FSF explictly
state that the code will always be free software, and they grant back
all rights to the code you assigned to them.
