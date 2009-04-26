From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Again with git-svn: File was not found in commit
Date: Sun, 26 Apr 2009 01:17:28 -0700 (PDT)
Message-ID: <m31vrfq11w.fsf@localhost.localdomain>
References: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com>
	<20090421180231.GB16642@dcvr.yhbt.net>
	<8EDD65AC-9C25-4281-86F6-E52A41331B00@kineticode.com>
	<20090426015300.GA17212@dcvr.yhbt.net>
	<81EFD289-5E46-4B27-8DA4-C2039915CE2D@kineticode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: "David E. Wheeler" <david@kineticode.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 22:44:31 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxzZt-00087o-6L
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 10:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbZDZIRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 04:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbZDZIRe
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 04:17:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:6931 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZDZIRc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 04:17:32 -0400
Received: by fg-out-1718.google.com with SMTP id d23so397946fga.17
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7it5h4CsabgEJcvcVFYWox3jRQk2htcwm+nVggzIcac=;
        b=M6eu/uW2bHYlMATcGhbQkIYocEpqqDlqsiRJQXPxX4vwQJfrDgZU3+0uxGlLlwGzol
         ATDP9kH8pLD7v7g0MSj0wi5dHb0gx4/HBXh4/q4PBE4l2ZU4UGbJxt/4YBLhUpUAp9G2
         ViThN0S8y/PJrPpJ40J4y/3DJ+vNLsYN4VIHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Qn1p0oym3paB+akBcfg+Jsh98+VrMTMT7mwMkOftVHWne093bteN8FuIibsSFD1x/b
         CB766Yj3JrrEkB1ton7jLjkHgiTCr5wSMXSHwOPZXBZMgumj+GKhCIoAoPITwtC3vrs2
         Q2UQtUioxvmwr0lM2QXIVLv3W8a4hHtW2LL/Q=
Received: by 10.86.36.11 with SMTP id j11mr2228419fgj.56.1240733848937;
        Sun, 26 Apr 2009 01:17:28 -0700 (PDT)
Received: from localhost.localdomain (abwp56.neoplus.adsl.tpnet.pl [83.8.239.56])
        by mx.google.com with ESMTPS id d4sm3757688fga.9.2009.04.26.01.17.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 01:17:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3Q8KMUF025130;
	Sun, 26 Apr 2009 10:20:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3Q8JtNC025114;
	Sun, 26 Apr 2009 10:19:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <81EFD289-5E46-4B27-8DA4-C2039915CE2D@kineticode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117592>

"David E. Wheeler" <david@kineticode.com> writes:

> On Apr 25, 2009, at 6:53 PM, Eric Wong wrote:
> 
> > Hopefully the workaround is working out for you.
> 
> [Finally], yes.
> 
> [Finally]: http://justatheory.com/computers/vcs/git/bricolage-to-git.html

Thank you for posting this detailed analysis.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
