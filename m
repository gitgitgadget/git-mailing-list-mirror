From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] Add git-save script
Date: Sat, 23 Jun 2007 10:08:40 -0500
Message-ID: <18045.14200.611958.870171@lisa.zopyra.com>
References: <20070623220215.6117@nanako3.bluebottle.com>
	<Pine.LNX.4.64.0706231605160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 17:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I27EF-0006AM-1m
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 17:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbXFWPIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 11:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757208AbXFWPIp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 11:08:45 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61722 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756289AbXFWPIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 11:08:45 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5NF8ga28814;
	Sat, 23 Jun 2007 10:08:42 -0500
In-Reply-To: <Pine.LNX.4.64.0706231605160.4059@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50740>

On Saturday, June 23, 2007 at 16:05:22 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Sat, 23 Jun 2007, Nanako Shiraishi wrote:
>
>> Here is how to use my script:
>> 
>>     $ git save
>>     $ git pull
>>     $ git save restore
>
>This use case has been discussed often, under the name "git-stash".

Was git-stash added as a patch yet?  If not, do you think Nanako's
patch does not address the concerns that were raised in the
discussion you refer to?


Bill
