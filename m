From: Steve Wagner <lists@lanwin.de>
Subject: Re: .gitk should created hidden in windows
Date: Tue, 17 Mar 2009 17:35:21 +0100
Message-ID: <49BFD149.1080707@lanwin.de>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AF295@EXCHANGE.trad.tradestation.com> <49BFCA68.2080800@lanwin.de> <450196A1AAAE4B42A00A8B27A59278E70A3FC063@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjcID-0003yo-Pr
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420AbZCQQf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbZCQQf7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:35:59 -0400
Received: from lanwin.de ([77.37.16.229]:35584 "EHLO vs5923.vserver4free.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbZCQQf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:35:58 -0400
Received: from [10.10.11.46] (unknown [213.61.128.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by vs5923.vserver4free.de (Postfix) with ESMTP id 6689A21687;
	Tue, 17 Mar 2009 17:35:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.6.666
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A3FC063@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113498>

John Dlugosz schrieb:
> Yes, I was thinking that I was confronted by these things more in Vista
> on a desktop, but can't remember exactly.  A lot of the directories are
> symbolic links that can't be clicked!  I'm running Windows 2003 which I
> think is based on the Vista core, but doesn't have the flashy UI candy,
> for servers.

As far as is know, 2003 is based on xp and the this large amount of
symbolic links are only there to dont break bad develop applications
which are not using variables like APPDATA.

> But, you would not see more clutter if it was in the place where your
> APPDATA environment variable points, right?

Yes this is the better approach on windows, but since it is only one
file, it would be ok to leave it there and make it hidden.

Steve
