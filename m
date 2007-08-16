From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Thu, 16 Aug 2007 13:57:23 +0200
Message-ID: <46C43BA3.6090807@gmail.com>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org> <1187037445.6628.98.camel@heimdal.trondhjem.org> <1187054366.2757.0.camel@laptopd505.fenrus.org> <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu> <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost> <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost> <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org> <20070814193333.GI21089@ftp.linux.org.uk> <46C2548D.80605@gmail.com> <alpine.LFD.0.999.0708151846130.16414@enigma.security.iitk.ac.in> <46C30220.6060007@gmail.com> <68B09015-4411-470A-BA88-732969469AA2@mac.com> <46C42DCB.1060502@gmail.com> <46C43015.7080804@gmail.com> <fa1c95$sv6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 14:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILe2g-00028p-N6
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 14:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbXHPMB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 08:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbXHPMB3
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 08:01:29 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:51801 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXHPMB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 08:01:28 -0400
Received: from [213.51.146.190] (port=37522 helo=smtp1.tilbu1.nb.home.nl)
	by smtpq2.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILe2Z-0004QG-FD; Thu, 16 Aug 2007 14:01:27 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:50840 helo=[192.168.0.3])
	by smtp1.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILe2X-0004qY-Mk; Thu, 16 Aug 2007 14:01:25 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <fa1c95$sv6$1@sea.gmane.org>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56009>

On 08/16/2007 01:26 PM, Salikh Zakirov wrote:

Please don't drop CCs.

> Rene Herman wrote:
>> Perhaps that immediately suggests an implementation to someone already
>> familiar with git internals?
> 
> perhaps http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
> and http://www.kernel.org/pub/software/scm/git/docs/git-check-attr.html
> can help you?

No, thanks, saw them, but .gitattributes is in fact in the same category as 
.gitignore, which would _be_ a property.

If you do this stuff in files scattered around the tree, updating and moving 
stuff becomes a pain -- the tool would need to go edit files.

Rene.
