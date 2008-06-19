From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Documentation: Simplify git-rev-parse's example
Date: Thu, 19 Jun 2008 14:12:02 -0500
Message-ID: <485AAF82.3030209@freescale.com>
References: <1213873976-4192-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:13:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9PZZ-00031G-Le
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbYFSTMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 15:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYFSTMe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:12:34 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:36755 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYFSTMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 15:12:34 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m5JJC3wf004080;
	Thu, 19 Jun 2008 12:12:04 -0700 (MST)
Received: from [10.214.73.115] (mvp-10-214-73-115.am.freescale.net [10.214.73.115])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5JJC2Tv005260;
	Thu, 19 Jun 2008 14:12:02 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1213873976-4192-1-git-send-email-pdebie@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85514>

Pieter de Bie wrote:
> This example was overly complex and therefore confusing.
> The commits have been renamed to start the oldest commit with "A"
> and working up from there. Also, this removes some commits so the graph
> is simpler. Finally the graph has been reversed in direction to make it
> more like gitk.
> 
> Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
> ---
> 
> This was created after some discussion in #git about how this was confusing.
> The consesus was that this example is better.

How is this a vast improvement?

I could see that inverting it top-to-bottom would
be more consistent with gitk or show-branch output.
Your example doesn't have a 3-parent commit, though,
and it isn't _that_ much simpler otherwise...

So this is really better _how_?

Oh, right, of course.  It removes my name.  Got it. :-)

jdl
