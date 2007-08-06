From: Miles Bader <miles@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Mon, 06 Aug 2007 09:13:01 +0900
Message-ID: <87abt5h65u.fsf@catnip.gol.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
	<85myx7dwb3.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org>
	<85bqdndqgr.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org>
	<85bqdmctcl.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org>
	<85bqdlj1lh.fsf@lola.goethe.zz>
	<7vr6mheem0.fsf@assigned-by-dhcp.cox.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 02:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHqD8-0008Ty-DL
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209AbXHFAMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 20:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758123AbXHFAMf
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:12:35 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:49949 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXHFAMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:12:34 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHqD2-0000sE-2y; Mon, 06 Aug 2007 09:12:32 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 4410B300F; Mon,  6 Aug 2007 09:13:01 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <7vr6mheem0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun\, 05 Aug 2007 16\:38\:47 -0700")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55089>

Junio C Hamano <gitster@pobox.com> writes:
> I've written documentaiton in texinfo format in the past, and one
> thing I found quite painful was maintaining the node header with
> prev/next links --- tedious, error prone and boring.

Actually, the prev/next/up parts of @node are optional in the input file
-- if you just leave them out, makeinfo will fill them in for you.

-miles

-- 
"Suppose we've chosen the wrong god. Every time we go to church we're
just making him madder and madder." -- Homer Simpson
