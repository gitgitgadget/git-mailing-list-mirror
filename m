From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 12:18:18 -0700 (PDT)
Message-ID: <m3fwpm2c6p.fsf@localhost.localdomain>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Searles <dsearles@medialab.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:18:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5a6-0007Pi-Vy
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757936Ab1DMTSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:18:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34396 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757668Ab1DMTSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:18:21 -0400
Received: by bwz15 with SMTP id 15so848187bwz.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=U27VSjkLEJxdzhA8XozTyneKlPrFr5VMIlKApuYxqUY=;
        b=uL6lEKhzmnLaa4/1KMjWm/xUD/DYhFdY6cIZXDIEJLkZ19zA0LW11aquF34mZ8pbvE
         EgRJPnRI48HBXtYGpJwwuoXpprjGPi95Uifdo+6OeogJC+Pm2dQKnUIq/f393EkBe40z
         ss3Er0ofUw0lWsIWzs41EfZ6RQAeog1X6+Pyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=eDYRyJzWMWpEOmF4q9bo5gbOlcid5oOGdOud1a1V5VCdr+iQJ8FgMI+jhl9SqzjMK0
         jmbCGs8gr5O8yr2NmKR9oFehWVUe6Zp8g1rQF9bvb/hX5A0sS0bZ5oY/t1clFaLw3Cz+
         QW0EdaBvbkciGydZV5lWQc0yKjGqIpbInzqzM=
Received: by 10.204.75.1 with SMTP id w1mr1229689bkj.132.1302722299734;
        Wed, 13 Apr 2011 12:18:19 -0700 (PDT)
Received: from localhost.localdomain (abwp92.neoplus.adsl.tpnet.pl [83.8.239.92])
        by mx.google.com with ESMTPS id t1sm515193bkx.19.2011.04.13.12.18.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 12:18:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3DJHkSK030251;
	Wed, 13 Apr 2011 21:17:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3DJHYAm030247;
	Wed, 13 Apr 2011 21:17:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171476>

Daniel Searles <dsearles@medialab.com> writes:

> Hi All,
> 
> I'm curious if Gitbox is in violation of the Git's GPL.
> http://www.gitboxapp.com/

It is graphical _interface_ for Git; I assume that it _uses_ Git.
Using a program, as opposed to including it (making derivative work),
is not covered by GPLv2.

It's not only proprietary Git GUI: there is also Sprout, SmartGit,
SourceTree (I think: my information might be outdated).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
