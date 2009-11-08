From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: early days before git's invention
Date: Sun, 08 Nov 2009 05:29:01 -0800 (PST)
Message-ID: <m3ws21rvrd.fsf@localhost.localdomain>
References: <2986b3940911080423p4ccfe279ia00c995e1ea23fb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zhi Li <lizhi1215@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 14:29:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N77pS-0006Kc-P3
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 14:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbZKHN26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 08:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbZKHN26
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 08:28:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:64014 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZKHN25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 08:28:57 -0500
Received: by fg-out-1718.google.com with SMTP id d23so389545fga.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 05:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+RNO1bhS5NWtK/Yy5L/gmLQOHIpPERuq1C84Vovorfk=;
        b=OsWbUANtpV9TrJNlATYBskZFWr6zm9E/tlY/eJxRuJKATBU6kv7FH8JXN6MF6gaDU7
         hisApjmJcrGcyOWzfp4BtprDP/qXF4igaXEQeeh3TIWRzI3u6lcnQZOolOKJpiIO0JyS
         /R+4TQ71dPOTIedktN7d6YxJbg4QEHUfZbXxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Iqi3NPqQvyyT/tRvXYqNtaOzWKA8sZY0I3ZbxmPvPSX3kge/DRHMJMsadxSQaR5157
         7Vs65RorAYa4p/HtVLfsrWinoa0YfIZXyxmzVmEpOIMZzcDgcbfJlQ5JH39GF8CGv57n
         FgJsqQjNYHwFINxrk4AjAl8b2htVoMczL3cXQ=
Received: by 10.103.122.29 with SMTP id z29mr2514077mum.53.1257686941947;
        Sun, 08 Nov 2009 05:29:01 -0800 (PST)
Received: from localhost.localdomain (abwu61.neoplus.adsl.tpnet.pl [83.8.244.61])
        by mx.google.com with ESMTPS id s10sm6749490muh.54.2009.11.08.05.29.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 05:29:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nA8DSYWM008482;
	Sun, 8 Nov 2009 14:28:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nA8DSN68008479;
	Sun, 8 Nov 2009 14:28:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2986b3940911080423p4ccfe279ia00c995e1ea23fb9@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132399>

Zhi Li <lizhi1215@gmail.com> writes:

> I have a question maybe not suitable to be put on this list. I'm just
> curious on git and Linux history. As what was said on wiki, Linux
> kernel was maintained by BitKeeper, then for some reason, BitKeeper
> can not be used, so git was invented. My question is what was used
> before BitKeeper, CVS? I don't think so. Then, just using file to
> manage?

For why BitKeeper could not be used, see:
  http://en.wikipedia.org/wiki/Git_(software)#Early_history
  http://git.or.cz/gitwiki/GitHistory
  http://kerneltrap.org/node/4982
  http://www.pcworld.idg.com.au/article/129776/after_controversy_torvalds_begins_work_git?fp=16&fpid=0

  http://better-scm.berlios.de/bk/demise-of-gratis-bitkeeper.html
  http://better-scm.berlios.de/bk/what-bitmover-got-wrong.html
  http://better-scm.berlios.de/bk/the-bitkeeper-ghost.html

Before BitKeeper Linux used tarballs (for releases) plus patches (for
changes); patches were send by email (on LKML).  Some maintainers used
tools like Quilt (or custom scripts) for patch management.


P.S. FreeBSD (IIRC) used / uses CVS for version control, but it has
quite different development model than Linux.

-- 
Jakub Narebski
Poland
