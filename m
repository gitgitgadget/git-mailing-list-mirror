From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 10:00:53 +0000
Message-ID: <FEE581A3-C858-45CF-B545-8F7187FCCE40@ai.rug.nl>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5ji-0006Qd-T0
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbZBSKBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZBSKBD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:01:03 -0500
Received: from frim.nl ([87.230.85.232]:51258 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752406AbZBSKBC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 05:01:02 -0500
Received: from 82-41-227-224.cable.ubr11.sgyl.blueyonder.co.uk ([82.41.227.224] helo=[192.168.50.101])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1La5iF-0000Wn-Id; Thu, 19 Feb 2009 11:00:59 +0100
In-Reply-To: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110657>


On 19 feb 2009, at 09:21, John Tapsell wrote:

>  Would there be any objections to making  'git rebase -i' default to
> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
> helps a bit with making it easier to use.

I'd prefer something a bit less arbitrary, like using the tracked head
for a tracking branch.
