From: David Miller <davem@davemloft.net>
Subject: Re: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 19:58:34 -0800 (PST)
Message-ID: <20090228.195834.104539194.davem@davemloft.net>
References: <20090301032035.GB30384@coredump.intra.peff.net>
	<20090228.194454.05711858.davem@davemloft.net>
	<20090301034632.GA318@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Mar 01 05:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldcqi-00036Y-UX
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 05:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbZCAD6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbZCAD6x
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:58:53 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48909
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755405AbZCAD6w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 22:58:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 55FF835C009;
	Sat, 28 Feb 2009 19:58:34 -0800 (PST)
In-Reply-To: <20090301034632.GA318@coredump.intra.peff.net>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111815>

From: Jeff King <peff@peff.net>
Date: Sat, 28 Feb 2009 22:46:33 -0500

> On Sat, Feb 28, 2009 at 07:44:54PM -0800, David Miller wrote:
> 
> > Thanks a lot Jeff, I'll try to fix the corruption using the
> > suggestions you gave me.
> 
> If it is real corruption, you might want to save a copy of the
> repository. I think Linus and Nicolas like to pick apart corruption to
> figure out if it is a git bug or a disk failure.

I have a copy saved.
