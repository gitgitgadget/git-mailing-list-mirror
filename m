From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 11:39:56 -0800 (PST)
Message-ID: <m33agtgp2v.fsf@localhost.localdomain>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDt8-00075e-Uq
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbYLLTkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbYLLTkA
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:40:00 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:64805 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYLLTj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:39:59 -0500
Received: by ewy10 with SMTP id 10so1940117ewy.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=j8X3p1zRih71r6xtKe8DeeqaPP40M0VBo9YCkCRc4No=;
        b=h9kT9acQ9KcqSaQ6+YMC+2Zn6htVR4AG5ECLzSrOir7SoeqJA4jZ0G4w4ADwrpL8XF
         8Jcu8i979IO1jc99Xa4LdmJcB5WLQtMgrJWY+AfmXW+2HcCoCu0EHbemEJD6CHbDi4BM
         TejXgWllibnuxn2d+rnaSrOnymMrcDaD+CWuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=jrwlgqKPwL2INv4J2d95XclC2JJFj492/DHBdmQFTer8RuIG2qghZus+zrfoTtSIvg
         Z+92kR8XxwRlWfNXD195wKBBUNf6ZvEDNihO4zVNhE//1JPcgiQQoa8ueVh8hv3dWn62
         KDnkkkGHUh5tx0sawFPBrRrI5msuNScjIlZLY=
Received: by 10.210.144.8 with SMTP id r8mr1233249ebd.169.1229110797123;
        Fri, 12 Dec 2008 11:39:57 -0800 (PST)
Received: from localhost.localdomain (abvt119.neoplus.adsl.tpnet.pl [83.8.217.119])
        by mx.google.com with ESMTPS id 5sm469639eyf.18.2008.12.12.11.39.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Dec 2008 11:39:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBCJdsAx002415;
	Fri, 12 Dec 2008 20:39:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBCJdqSR002412;
	Fri, 12 Dec 2008 20:39:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102933>

David Howells <dhowells@redhat.com> writes:

> Add a guide to using GIT's simpler features.

Wouldn't it be better to update either "Git User's Manual",
or http://book.git-scm.com?

See also: http://git.or.cz/gitwiki/GitDocumentation (including "Git
Magic", "Git in Nutshell", "Git for computer scientists" and "Git from
bottoms up"
-- 
Jakub Narebski
Poland
ShadeHawk on #git
