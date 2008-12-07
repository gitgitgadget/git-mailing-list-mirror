From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: missing "commit | commitdiff | tree | snapshot" within we web git page
Date: Sun, 07 Dec 2008 13:30:45 -0800 (PST)
Message-ID: <m3zlj7hdvh.fsf@localhost.localdomain>
References: <200812072155.52456.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-14?q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 22:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9RET-0006rr-2m
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 22:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbYLGVas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2008 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbYLGVas
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 16:30:48 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:6322 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYLGVar convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2008 16:30:47 -0500
Received: by ey-out-2122.google.com with SMTP id 6so346843eyi.37
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 13:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=yWfrnSW5Utsj7AgJz/teOf5FnVf9MwLZZOy9nowEryQ=;
        b=MdzRSQ/hq69eNbnFRvTz6KGVozwB7JXi5tmZ5R5vN+kVPudLExHTxVrlnce0pWuD4Q
         /Qeq7HKqGpckI9H4xMmyVAPqHfhHEbvyf9tlCzWh7oLDcBmkYIYCTEZGYfZVZpp7wPag
         +W8RSew79Euz2yJV5QFe9C/5uHMIyI0TrGMfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=vmAZH+JkJAYobBy9Pw7PqN2/4F3WhDUc+YPSC/a4hfObs80AYic+9l7DRQKjI8BW/+
         +gD0a8XqnGmrSI5rKRzB1ocgJflKq+HldBvTTlDF1jQtB5JxmdFP4ApOse4jun4eAiDb
         W+t6ZbYTRGDyeICb1dboHfFdkEGEVVYHTQXf8=
Received: by 10.210.123.2 with SMTP id v2mr2809156ebc.0.1228685445950;
        Sun, 07 Dec 2008 13:30:45 -0800 (PST)
Received: from localhost.localdomain (abvk203.neoplus.adsl.tpnet.pl [83.8.208.203])
        by mx.google.com with ESMTPS id b33sm18757403ika.23.2008.12.07.13.30.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 13:30:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB7LUiYL030841;
	Sun, 7 Dec 2008 22:30:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB7LUgMq030838;
	Sun, 7 Dec 2008 22:30:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200812072155.52456.toralf.foerster@gmx.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102508>

Toralf F=F6rster <toralf.foerster@gmx.de> writes:

> While watching this=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.27.y.git=
;a=3Dshortlog=20
> I'm wondering why the last line doesn't contain sth. like
> "commit | commitdiff | tree | snapshot"

It contains it?

Unless you are talking about line with the 'next' link...
--=20
Jakub Narebski
Poland
ShadeHawk on #git
