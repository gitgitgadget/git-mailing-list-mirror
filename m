From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Wed, 30 May 2007 18:12:29 +0200
Message-ID: <87k5uqp9xu.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
	<871wh0ww80.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705281957160.26602@woody.linux-foundation.org>
	<87r6ozs7q5.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705291412060.26602@woody.linux-foundation.org>
	<87k5uqqz0y.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705300832410.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 30 18:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtQmo-00006V-LL
	for gcvg-git@gmane.org; Wed, 30 May 2007 18:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbXE3QMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 12:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbXE3QMc
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 12:12:32 -0400
Received: from mx.meyering.net ([82.230.74.64]:40347 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbXE3QMb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 12:12:31 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 0025028A7E; Wed, 30 May 2007 18:12:29 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0705300832410.26602@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 30 May 2007 08\:40\:57 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48770>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
[...big flame!...]

Wow!  This is like the scene from the Wizard of Oz:
I've just raised the curtain and seen who's behind it.

Jim
