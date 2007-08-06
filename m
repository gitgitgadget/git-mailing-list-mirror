From: Miles Bader <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 09:00:12 +0900
Message-ID: <87fy2xh6r7.fsf@catnip.gol.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<200708051411.25238.johan@herland.net>
	<20070805161117.GE28263@thunk.org>
	<200708052116.04140.johan@herland.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 01:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHq0k-0006Si-4B
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 01:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbXHEX7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757941AbXHEX7r
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 19:59:47 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:36154 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbXHEX7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 19:59:46 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHq0e-0007gy-IJ; Mon, 06 Aug 2007 08:59:44 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id F1E47300F; Mon,  6 Aug 2007 09:00:12 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <200708052116.04140.johan@herland.net> (Johan Herland's message of "Sun\, 05 Aug 2007 21\:16\:03 +0200")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55086>

Johan Herland <johan@herland.net> writes:
>> # git config --system --add alias.addremove "git add . ; git add -u"
>
> But I'm wondering whether we'd want to include it in git by default (instead 
> of having to tell confused users to add the alias).

An easier-to-type name e.g. "addrm" would be good though...

-miles

-- 
`Life is a boundless sea of bitterness'
