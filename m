From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git roadmap (How read What's cooking in git.git)
Date: Thu, 18 Nov 2010 06:05:51 -0800 (PST)
Message-ID: <m3ipzu682o.fsf@localhost.localdomain>
References: <AANLkTimtUz3L0F_iOpH7YuYpyoutPqtevPj-Tjo6MRcs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 15:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ57p-0005RT-A7
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 15:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758184Ab0KROF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 09:05:57 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43716 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758213Ab0KROFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 09:05:54 -0500
Received: by eye27 with SMTP id 27so1912041eye.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=9+7yCxnQwT8f0MklChLgIeoEBZa2jZ+YnYFNKSdhJrE=;
        b=oNtpw+zg3WUm+v4+EfpPQvYeSpya8L8qs64o1Gkoh9oHPK9YNIbzYwUY4JTt4N0HLO
         YkyrBnnAXOTo+4NecgBf8g/yi6WyKwdVGfkUA1QkqWb80YPZiqbMXYcrB7NGgRr2VHgJ
         zYe7BOwt8aHW9EtuZzv3rct1XsBEVE9HG+Kxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=kVYxVg5OwCw8W3XEAiJrIEqrKc3SRV2kp+mVDfeW3efxnkwyZJPA4erD29U9jNfaYp
         mosEy4SkaVNdZf1ueuAo+oEIqhb0Q8AMV0zHm4sU4GWxBwhnsvvHPHs3jOf8WAOiTPEU
         n+tqxiK6rfw7buHL64M3vW9h9dWt6PMjHo8n8=
Received: by 10.213.108.130 with SMTP id f2mr515025ebp.73.1290089152974;
        Thu, 18 Nov 2010 06:05:52 -0800 (PST)
Received: from localhost.localdomain (abva111.neoplus.adsl.tpnet.pl [83.8.198.111])
        by mx.google.com with ESMTPS id q58sm417186eeh.3.2010.11.18.06.05.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 06:05:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAIE5UIT020939;
	Thu, 18 Nov 2010 15:05:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAIE5KSJ020933;
	Thu, 18 Nov 2010 15:05:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimtUz3L0F_iOpH7YuYpyoutPqtevPj-Tjo6MRcs@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161669>

Sebastien Douche <sdouche@gmail.com> writes:

> I'm starting a french blog[1] on git to support workshops[2]. The goal
> is to explain deeply the philosophy, the commands and subcommands,
> workflows, etc. And also to aggregate headlines of the git world,
> follow events and announce git releases. For the latter, it's a bit
> hard (for a non core developer) to follow the development. From your
> point of view, how we could set up a roadmap and a "what's new"?
> 
> [1] http://blog.gitfr.net

There is Junio's blog which sometimes contain interesting bits about git:

  http://gitster.livejournal.com/


There is also "A git blog looking to be official" (with announcements
and git top links, etc)

  http://gitlog.wordpress.com/



I know that it doesn't really answer your question, but Git User's Surveys
included question about what features one would want in Git, see for example

  https://git.wiki.kernel.org/index.php/GitSurvey2010

-- 
Jakub Narebski
Poland
ShadeHawk on #git
