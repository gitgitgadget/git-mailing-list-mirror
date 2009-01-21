From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Few Questions
Date: Wed, 21 Jan 2009 03:08:43 -0800
Organization: Slide, Inc.
Message-ID: <1232536123.3477.638.camel@starfruit>
References: <726600.29783.qm@web35708.mail.mud.yahoo.com>
	 <m3r62yx9qi.fsf@localhost.localdomain> <20090120160410.GI14053@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, m.arya@yahoo.com,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 12:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPayq-0003Is-1x
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 12:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbZAULJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 06:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755053AbZAULJU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 06:09:20 -0500
Received: from mx0.slide.com ([208.76.68.7]:55902 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662AbZAULJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 06:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=u
	U08ovtYxco0sp4POEPBGtile8v6iqFZCncXCxoYrd8=; b=cPwCt6YWerUD58oOq
	jCQ0r6Osp1URhem7Yte1B8bLI+pTl5ZV/Lvl0x0CXbF6vgZhhnNlfVWj2N2uIX7a
	NMzzdd1bc1TOmQE1HVQd5fXwjbZzJ8wVxyGvszdau3EbEXymMuINDttXU+WXKGI+
	IObzPy1IIXGHiQVBkDmRlGGPXU=
Received: from nat3.slide.com ([208.76.69.126]:57753 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LPaxR-0001Ox-St; Wed, 21 Jan 2009 03:09:17 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id D7267A6F0002;
	Wed, 21 Jan 2009 03:09:17 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -1.443
X-Spam-Level: 
X-Spam-Status: No, score=-1.443 tagged_above=-10 required=6.6
	tests=[AWL=-1.491, BAYES_00=-2.599, FH_HOST_EQ_PACBELL_D=1.67,
	RCVD_IN_SORBS_DUL=0.877, RDNS_DYNAMIC=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LisFDkkmzelc; Wed, 21 Jan 2009 03:09:03 -0800 (PST)
Received: from [192.168.250.107] (adsl-69-226-215-237.dsl.pltn13.pacbell.net [69.226.215.237])
	by calculon.corp.slide.com (Postfix) with ESMTP id 4B257A6F0001;
	Wed, 21 Jan 2009 03:09:03 -0800 (PST)
In-Reply-To: <20090120160410.GI14053@spearce.org>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106595>

On Tue, 2009-01-20 at 08:04 -0800, Shawn O. Pearce wrote:
> <plug type="not-quite-ready-but-will-be-soon">
> 
> Gerrit2 is also likely to enter this "market" soon.  I'm trying to
> get it production ready and live for one major project before the
> end of this month.  It embeds its own SSH daemon on a non-standard
> port, completely disconnected from the OS authentication.  This may
> make it slightly more palatable in some enviroments then Gitosis,
> as you don't need a huge authorized_keys file, and you don't have
> to worry quite so much about attack vectors.

> </plug>
> 

<plug type="not-really-existent-yet-but-gee-golly-i-wish-it-were"
variant="mildly-offtopic" unnecessary:attribute="is-unnecessary">

I talked with Chris Wanstrath (defunkt) of Git Hub once upon a time
about them open sourcing their additions onto the openSSH sshd(8) to
work public key lookup into a MySQL database instead of simply reading a
flat file. 

It'd be nice to add some peer pressure to get them to release it
already ;)

</plug>

I read your thread(s) on groups.google.com regarding Gerrit2 and it
seems quite promising as well. Looking forward to it being ready ;)

Cheers
-- 
-R. Tyler Ballance
Slide, Inc.
