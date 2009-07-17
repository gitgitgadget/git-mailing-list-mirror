From: Unknown <borg@uu3.net>
Subject: Re: [commit 4ecbc178704] Incosistency?
Date: Fri, 17 Jul 2009 19:42:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907171939350.5833@cube>
References: <Pine.LNX.4.64.0907142335210.31779@cube>
 <20090714214852.GA2786@coredump.intra.peff.net> <Pine.LNX.4.64.0907151028050.10773@cube>
 <20090715094252.GA26048@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:42:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRrRw-0006dO-Vm
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 19:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbZGQRmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 13:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbZGQRmR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 13:42:17 -0400
Received: from borg.uu3.net ([87.99.63.19]:35191 "EHLO borg.uu3.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964806AbZGQRmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 13:42:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.uu3.net (Postfix) with ESMTP
	id E4BBB633F9; Fri, 17 Jul 2009 19:42:13 +0200 (CEST)
X-X-Sender: borg@cube
In-Reply-To: <20090715094252.GA26048@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123478>

Sorry for long answer.. my CRT died.. and I had to get temp replacement.

After resolving conflicts it should work clean on my old cygwin too.
So no problem. I think its best to close this topic.

Regards,
Borg

On Wed, 15 Jul 2009, Jeff King wrote:
> Sorry, I don't understand the significance. Is having 'git' in the
> execdir causing some kind of problem?
>
> I agree that it shouldn't be necessary for most sane setups, but sadly
> there are some insane ones, and I don't think this solution should be
> hurting anyone else. Am I wrong?
>
> -Peff
>
