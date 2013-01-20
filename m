From: Stephen Kelly <steveire@gmail.com>
Subject: Re: git interactive rebase 'consume' command
Date: Sun, 20 Jan 2013 15:23:11 +0100
Message-ID: <kdgukd$jlm$1@ger.gmane.org>
References: <kdgtir$apt$1@ger.gmane.org> <20130120141725.GL31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 15:23:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwvoI-0002cN-0V
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 15:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab3ATOXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 09:23:25 -0500
Received: from plane.gmane.org ([80.91.229.3]:54927 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab3ATOXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 09:23:24 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TwvoA-0002aL-QO
	for git@vger.kernel.org; Sun, 20 Jan 2013 15:23:38 +0100
Received: from g231115249.adsl.alicedsl.de ([92.231.115.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 15:23:38 +0100
Received: from steveire by g231115249.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 15:23:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g231115249.adsl.alicedsl.de
User-Agent: KNode/4.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214021>

John Keeping wrote:
>> Any thoughts on that?
> 
> Are you aware of the "--autosqush" option to git-rebase (and the
> "rebase.autosquash" config setting)?  I find that using that combined
> with the "--fixup" option to git-commit makes this workflow a lot more
> intuitive.

Yes, I'm aware of it, but I think it's not related to the proposal I made. 

Mostly my proposal is about avoiding unnecessary conflict resolution.

Thanks,

Steve.
