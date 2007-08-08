From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodules
Date: Wed, 08 Aug 2007 15:08:07 -0700
Message-ID: <7vzm111xyw.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
	<Pine.LNX.4.64.0708072349400.14781@racer.site>
	<a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
	<20070808104117.GK999MdfPADPa@greensroom.kotnet.org>
	<7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vps1x3ihp.fsf@assigned-by-dhcp.cox.net>
	<20070808200831.GS999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu Aug 09 00:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIthQ-0007BN-IW
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbXHHWIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 18:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbXHHWIM
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:08:12 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47324 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359AbXHHWIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:08:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808220808.VJAL26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 18:08:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Za871X00Q1kojtg0000000; Wed, 08 Aug 2007 18:08:08 -0400
In-Reply-To: <20070808200831.GS999MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 08 Aug 2007 22:08:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55378>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Wed, Aug 08, 2007 at 12:59:30PM -0700, Junio C Hamano wrote:
>> Sorry, but I do not use submodules yet myself.
>
> If you would ever start using submodules (for, say, gitgui),
> then I'm sure we'd have much more usable submodules support
> in no time.

Heh, I do not have infinite time to spend on every little corner
features, and have been hoping that other people who have more
immediate need of submodule support to be the guinea pigs to
encounter real-life issues first and come up with solutions to
them, before I start using it.

So far, I think the plan has been working out alright ;-).
