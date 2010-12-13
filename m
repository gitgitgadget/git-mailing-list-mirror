From: Andreas Ericsson <ae@op5.se>
Subject: Re: native-style key bindings for gitk on Mac OS X
Date: Mon, 13 Dec 2010 09:30:16 +0100
Message-ID: <4D05D998.5080107@op5.se>
References: <681947AB-F2D2-4EBC-A635-09E28FC27256@at.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hans-Christoph Steiner <hans@at.or.at>
X-From: git-owner@vger.kernel.org Mon Dec 13 09:30:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS3ni-00014y-6u
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 09:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab0LMIaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 03:30:21 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:42734 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab0LMIaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 03:30:20 -0500
Received: by eyg5 with SMTP id 5so3989856eyg.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 00:30:19 -0800 (PST)
Received: by 10.213.105.197 with SMTP id u5mr2181114ebo.36.1292229018833;
        Mon, 13 Dec 2010 00:30:18 -0800 (PST)
Received: from [192.168.1.186] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id u1sm2599523eeh.4.2010.12.13.00.30.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 00:30:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Thunderbird/3.1.6 ThunderGit/0.1a
In-Reply-To: <681947AB-F2D2-4EBC-A635-09E28FC27256@at.or.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163523>

On 12/12/2010 11:08 PM, Hans-Christoph Steiner wrote:
> 
> Hey all,
> 
> This is my first post here, hopefully I'm not doing anything stupid
> ;) I use gitk on Debian, Ubuntu, and Mac OS X. I'm big on having apps
> feel native on each platform. Currently gitk's key bindings are very
> GNU/Linux-ish when using gitk on Mac OS X. I'd like to submit a patch
> to make gitk use native-style key bindings and re-use common key
> bindings.

So long as the patch lets the original keys work (ie, people who are
used to them as they are now aren't suddenly hit by a nasty surprise),
I think it's a great idea.

> Before starting this, I just wanted to make sure this isn't some
> hotly debated political issue.
> 

It will be if the old keys stop working or all of a sudden do something
different. Especially if the new thing it does isn't exactly harmless
but the old thing was.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
