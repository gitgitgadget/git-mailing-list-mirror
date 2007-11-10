From: Miles Bader <miles@gnu.org>
Subject: Re: Inconsistencies with git log
Date: Sun, 11 Nov 2007 07:51:55 +0900
Message-ID: <87d4uhaf3o.fsf@catnip.gol.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	<Pine.LNX.4.64.0711072242230.4362@racer.site>
	<9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	<Pine.LNX.4.64.0711072255420.4362@racer.site>
	<9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqzBZ-0006X3-6i
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 23:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbXKJWwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 17:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbXKJWwB
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 17:52:01 -0500
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:52117 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbXKJWwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 17:52:00 -0500
Received: from 203-216-100-114.dsl.gol.ne.jp ([203.216.100.114] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IqzBF-000815-E1; Sun, 11 Nov 2007 07:51:57 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id CA5B02FF6; Sun, 11 Nov 2007 07:51:55 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> (Jon Smirl's message of "Wed\, 7 Nov 2007 18\:03\:12 -0500")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64386>

"Jon Smirl" <jonsmirl@gmail.com> writes:
> But if you type 'git log' while cd'd into a subdirectory the whole log
> is almost never what you want. It's this kind of thing that makes git
> harder to use.

Actually I almost always want the "whole project history" when cd'd to a
subdir.

Git's convention of doing the whole project by default, but allowing "."
(or any other directory name) to narrow it down seems almost perfect to
me.

-Miles

-- 
"Don't just question authority,
Don't forget to question me."
-- Jello Biafra
