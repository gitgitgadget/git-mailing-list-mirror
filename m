From: Rune Zedeler <rz@daimi.au.dk>
Subject: Re: Git-bug: Dependency of curl
Date: Tue, 23 Jan 2007 03:53:10 +0100
Message-ID: <45B57896.9050600@daimi.au.dk>
References: <45B52E5A.1050706@daimi.au.dk> <1169515666.5868.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 03:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Bma-0006Vb-44
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 03:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbXAWCxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 21:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXAWCxI
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 21:53:08 -0500
Received: from mx05.stofanet.dk ([212.10.10.25]:51160 "EHLO mx05.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932671AbXAWCxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 21:53:07 -0500
Received: from 56340cee.rev.stofanet.dk ([86.52.12.238])
	by mx05.stofanet.dk (envelope-from
	<rz@daimi.au.dk>)
	with esmtp id 1H9BmS-0001V3-1C; Tue, 23 Jan 2007 03:53:04 +0100
User-Agent: Thunderbird 1.5.0.9 (X11/20070104)
To: James Purser <purserj@k-sit.com>
In-Reply-To: <1169515666.5868.26.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37478>

James Purser wrote:

> I've brought this to the notice of the Ubuntu guys (via Launchpad etc).
> From what I can understand the way they've got it setup is as a
> "recommended" rather than "required" download.

Okay, thanks.
As curl is commonly used with git, and ubuntu-users (yours truly 
included) are not used to packages not working out of the box, it would 
be nice with a more pedagogical error message if you try to use git with 
curl and curl is not installed.

-Rune
