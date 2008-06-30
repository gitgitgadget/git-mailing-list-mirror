From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] Single system account for multiple git users
Date: Mon, 30 Jun 2008 11:56:57 -0500
Message-ID: <48691059.4060604@freescale.com>
References: <20080630151113.GO5737@dpotapov.dyndns.org>	 <alpine.DEB.1.10.0806300858380.25384@alchemy.localdomain> <37fcd2780806300951sd164870ib09bfc5e47dcaa57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:58:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDMhn-0006IF-94
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 18:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbYF3Q5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbYF3Q5W
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 12:57:22 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:33984 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbYF3Q5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 12:57:21 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m5UGvEdS028524;
	Mon, 30 Jun 2008 09:57:14 -0700 (MST)
Received: from [10.214.73.148] (mvp-10-214-73-148.am.freescale.net [10.214.73.148])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5UGvDZw028945;
	Mon, 30 Jun 2008 11:57:13 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <37fcd2780806300951sd164870ib09bfc5e47dcaa57@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86922>

Dmitry Potapov wrote:

> "The next thing to do is to create a user that will own the repositories
> you want to manage. This user is usually called git, but any name will
> work, and you can have more than one per system if you really want to.
> The user does not need a password, but does need a valid shell
> (otherwise, SSH will refuse to work)."

Does that just mean that the git-shell program
has to be listed in /etc/shells?

jdl
