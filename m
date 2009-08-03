From: John Tapsell <johnflux@gmail.com>
Subject: Re: From P4 to Git
Date: Tue, 4 Aug 2009 00:37:05 +0300
Message-ID: <43d8ce650908031437h3c2e899ey849053d7428a3105@mail.gmail.com>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:37:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5Dd-0002pS-Aw
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 23:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbZHCVhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 17:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbZHCVhG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 17:37:06 -0400
Received: from mail-yw0-f177.google.com ([209.85.211.177]:53549 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZHCVhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 17:37:06 -0400
Received: by ywh7 with SMTP id 7so4431309ywh.21
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=B70uOVb4WlIY0qhTtRvpOj4ZrOnsK+t5CZdESASS2pA=;
        b=INzp1r7nHPbdJj6pSboUI7upSPHkTydjt11+mhZ920LEFt6U9ocSyCgPqSo6rd+tbT
         /MXEtqVjlWv2o1NeSXKF+UHHEfdMVifLh0MhUfHjQLsOciGm8K4oGbKScNH1Plibx98c
         My+SHNzRI+pEfINnhi1IuYPjRJh8QYZQVHCSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=cV+JA7yTCUPaXT6AWoONiRQigvG7jioJfSwCNxw+kzvIvWGtps/KLaLXxWtDNChXHu
         o47dbuxtvzL49N2f3YpsHLlmBShNd007TwiLulyTFmw+di9gHeADvWbD09hxCTNxDrRi
         I9amVsFn94jho2IBBToK9ANMw42+YhbMbOSmQ=
Received: by 10.150.152.17 with SMTP id z17mr10249163ybd.280.1249335425377; 
	Mon, 03 Aug 2009 14:37:05 -0700 (PDT)
In-Reply-To: <m3fxcg3473.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124722>

2009/7/29 Jakub Narebski <jnareb@gmail.com>:
> If ou can't do that, you would probably be better with other version
> control system, like Subversion (IIRC both KDE and OpenOffice.org
> chosen this free centralized version control system).

Going a bit off topic - but to clarify, KDE hasn't really 'chosen' svn
over git, it's that we haven't switched to git _yet_. It just takes
time.  We already have trial projects (Amarok, for example, has
switched to git to lead the way) and I'm not sure if git submodule
support is mature enough, but baring any major problems we will
switch.

John
