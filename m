From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: repo.or.cz wishes?
Date: Tue, 28 Aug 2007 01:27:47 +0200
Message-ID: <200708280127.47808.jnareb@gmail.com>
References: <20070826235944.GM1219@pasky.or.cz> <46D356F9.1010506@vilain.net> <alpine.LFD.0.999.0708271616520.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Martin Mares <mj@ucw.cz>,
	Petr Baudis <pasky@suse.cz>, skimo@liacs.nl,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 01:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPnzy-00015f-Di
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbXH0X1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXH0X1w
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:27:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:51903 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbXH0X1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 19:27:51 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1311083nfb
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 16:27:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=goCFME41lM+jJIPcwKFbCHW5zwSmYU8AqKP8wGbQV+IQSaR/YYxUeJVllq59/HZgGhzzJGRYeLXAS6S1y1O7xPVF4TfNIcqkzozLJsz9NU9smpiZlKD5iyCNU4JH2dqGv4+rJYV13nw+LyzDaJypr6GkM65UaqSdhPR0lgZpDmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Dn4pTkv8RcBcwVWl84mYWBq2zp4CdpShO1X3t4gepXNwPXYmycXZT7XDDIkn6mAL7iJw3AwGGfALOJ2G/kWDu1kAxB49uP4fyPQ0PmdYMTt4uKhZUvtCVaGh402syKc+yG6srNG9rMqcGen3hMrXAFE4ovvNZt5Vb52NEZa+bqg=
Received: by 10.86.1.1 with SMTP id 1mr3583314fga.1188257270037;
        Mon, 27 Aug 2007 16:27:50 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id a37sm7342142fkc.2007.08.27.16.27.46
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 16:27:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.0.999.0708271616520.25853@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56895>

Linus Torvalds wrote:
> 
> On Tue, 28 Aug 2007, Sam Vilain wrote:
> > 
> > This is fine for URIs passed into git, but bad if you want to link to it
> > from elsewhere.
> 
> ..and by that logic, you should add "git+" to *everything*, not just ssh.
> 
> Which simply isn't practical or sane - only damn annoying.

Not exactly. You can browse using http:// and file:// protocols,
rsync:// is simply rsync, while ssh:// (or git_ssh://) can be limited
using git-shell.

-- 
Jakub Narebski
Poland
