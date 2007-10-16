From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 11:51:55 -0400
Message-ID: <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhoiP-0000VD-4p
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389AbXJPPwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbXJPPwG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:52:06 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:42986 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933274AbXJPPwD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 11:52:03 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9GFq050011801;
	Tue, 16 Oct 2007 11:52:00 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9GFpxQf010988
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Oct 2007 11:51:59 -0400 (EDT)
In-Reply-To: <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61200>


On 16 Oct 2007, at 11:26:07 AM, Jeffrey C. Ollie wrote:

> Instead of using "(setq indent-tabs-mode t)" use "(setq indent-tabs- 
> mode
> nil)".  This will force emacs to always use spaces to indent.

That's part of the problem to begin with:
people are using both way of indentation.

I suggest this not be allowed, or that it
be the only way of indenting.

However, 8 spaces per tab is a lot of wasted
information to be bandying about.

Michael Witten
