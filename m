From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 11:53:54 -0500
Message-ID: <BB55CC0E-DD0C-4870-8806-B037DE159051@silverinsanity.com>
References: <47382506.1090106@viscovery.net> <1194877277-31777-1-git-send-email-pkufranky@gmail.com> <20071112144605.GA16791@ins.uni-bonn.de> <46dff0320711120717gf8a67cdn2b6bdaa9cfa29218@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcYB-0003B4-DD
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbXKLQx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbXKLQx5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:53:57 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:35474 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbXKLQx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:53:57 -0500
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E8F841FFC22C;
	Mon, 12 Nov 2007 16:53:55 +0000 (UTC)
In-Reply-To: <46dff0320711120717gf8a67cdn2b6bdaa9cfa29218@mail.gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64663>


On Nov 12, 2007, at 10:17 AM, Ping Yin wrote:

> I just guess '\r' is need for Mac OS because i havn't Mac OS  
> environment.
> BTW, how to add a literal carriage return?

OS X's command line environment is modeled after BSD and uses the nice  
and sane \n as a line ending.  And since earlier Mac OS versions (that  
did use \r) don't have a command line, I don't see people using git on  
them.

~~ Brian
