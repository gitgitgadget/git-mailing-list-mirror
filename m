From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 7 May 2007 17:10:32 +0200
Message-ID: <20070507151032.GA26761@cip.informatik.uni-erlangen.de>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500> <7vejlufmhd.fsf@assigned-by-dhcp.cox.net> <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500> <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com> <002801c790ae$d86a1a90$0200a8c0@AMD2500> <Pine.LNX.4.64.0705071624210.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Gray <angray@beeb.net>, Johannes Sixt <J.Sixt@eudaptics.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 07 17:12:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl4sl-0007cI-GB
	for gcvg-git@gmane.org; Mon, 07 May 2007 17:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934278AbXEGPKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 11:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934272AbXEGPKe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 11:10:34 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:47411 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934219AbXEGPKe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 11:10:34 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 51CE53F302; Mon,  7 May 2007 17:10:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705071624210.4167@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46466>

Hello,

        (thinkpad) [~/work/git] cat git*.sh | wc -l
        6125

it should be possible to convert 6000 loc by hand. There is also a Google
Summer of Code Project targeting at that specific topic.

        Thomas
