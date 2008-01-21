From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Time to flush Mr. Hammano?
Date: Mon, 21 Jan 2008 11:13:55 -0800 (PST)
Message-ID: <m3odbfkn4s.fsf@roke.D-201>
References: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
	<20070624192215@qkholland.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Quim K Holland <qkholland@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH26H-000443-M6
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYAUTOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbYAUTOA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:14:00 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:10366 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYAUTN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:13:59 -0500
Received: by ik-out-1112.google.com with SMTP id c28so95852ika.5
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=OadHGCNJTlsJ30tv9FWTnI4c5JYA9GsQF4epPVuPew4=;
        b=jEPgzVQGlG0hV4AolrECHn4ID44Rxle2PMnvmpWSpcoAwjvOAFwyTlZBKt00qXg+kFx6jQ+JZZVFdqZknq2uzFsCyg/+KepahD6bHVTNTDmRmlekulAcwu5o8fS5sn4M9VzXzZU4U3PmxjnwDJ4QIn70sU/Es8e2kGycVonY4oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=nv6r64KvxVdQcbgYk4pQp/+putVsrzExklXRTozltVJwyXUG31wHGkhexHZ4XCthT2YBuOZWrlJgTdyuZl8w9JSnINHoQUcmvOMh4quoU0bZWwotq78TggvCrTf+7iFribX6XjwRXJc+B1IrWm6UdswA9JIpiVeAO+g2Kn0DfZE=
Received: by 10.78.173.20 with SMTP id v20mr9750659hue.12.1200942836702;
        Mon, 21 Jan 2008 11:13:56 -0800 (PST)
Received: from roke.D-201 ( [83.8.243.150])
        by mx.google.com with ESMTPS id c14sm13773423nfi.6.2008.01.21.11.13.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Jan 2008 11:13:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0LJDmvg029013;
	Mon, 21 Jan 2008 20:13:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0LJDeMb029010;
	Mon, 21 Jan 2008 20:13:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20070624192215@qkholland.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71312>

Quim K Holland <qkholland@gmail.com> writes:

> Back when Mr. Torvalds was still leading the development there was
> not this stupid stability freeze and many useful patches were
> accepted every day.  For the past few months Mr. Hammano has not
> been adding much useful code himself, did not join interesting
> discussions such as Unicode normalization issues, nor gave much
> useful comments on patches. He has mostly been busy rejecting useful
> patches and sending not so useful comments.
> 
> Can we vote Mr. Hammano out and ask Mr. Torvalds to come back as the
> project leader?  I do not mean any disrespect to Mr. Hammano, but
> don't people think he outlived his usefulness as the project leader?

First, Linus Torvalds passed maintaining git to Junio C Hamano because
he wanted to concentrate on Linux kernel; distributed version control
tool is just the means to do that.  I don't think Linus would want to
be back to maintaining git: it is a hard work.

Second, development and development speeds differ from the "creating"
pre-1.0 stage (for git when it was being written and then maintained
by Linus), and the mature development / improvement stage (for git
being maintained by Junio).

Third, git is now in feature freeze before main release, so it is
better that Junio concentrates on fixing bugs than on longish
discussions or new features.


Last, you don't follow netiquette: you don't know how to cite / quote
properly, you didn't word-wrap what you have wrote, you don't
contribute neither to discussion nor git code.

Have a nice life... in killfile!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
