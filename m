From: Tim Mazid <timmazid@hotmail.com>
Subject: git version numbers
Date: Sun, 29 May 2011 06:13:22 +1000
Message-ID: <20110528201321.GA26017@Imperial-SD-Longsword>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 22:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQPtF-0005G0-1N
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 22:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab1E1UNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 16:13:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43251 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab1E1UN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 16:13:29 -0400
Received: by pwi15 with SMTP id 15so1199482pwi.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:subject:message-id
         :mime-version:content-type:content-disposition:user-agent;
        bh=hHCg0MnXR8nDCjFkksRPfTpXHAZcvQGyc00wh6K+/ZQ=;
        b=r1sd3I1yyVUNjfAzHt/l5c1Lm5U+829Y11GTnUZ9+8cvCH/ZFIpPz5Vvt6vK/KLDKo
         Ut4y9IFpGWkLfe2FFKQ3SPsszYigahTBOL64Oi+Lsawzw13BxaooFnSVE/G8Notvwele
         vrKrCFuBYkWXod+hnJoFGyi3+RD4iqgU9y64s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=ZU72uCNtv8ENK4jUHEmqZ2rPu0CEIDhfXkr0LLkvsn4bEj0CdZVwUvbhEtx8sUMA7n
         o1k5jqPOIeHxNM9CaBS/5XiDtmQlopSJlUOEEOQXfCM6vhvMc8tS0XidjojdDdsaA19d
         Vs+AnRPtn60I9vFXCsVCJsH59S5kxtoZgaF1M=
Received: by 10.68.29.133 with SMTP id k5mr1352947pbh.467.1306613609474;
        Sat, 28 May 2011 13:13:29 -0700 (PDT)
Received: from Imperial-SD-Longsword ([120.152.94.229])
        by mx.google.com with ESMTPS id w5sm1540446pbh.61.2011.05.28.13.13.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2011 13:13:28 -0700 (PDT)
Received: from tim by Imperial-SD-Longsword with local (Exim 4.76)
	(envelope-from <tim@imperial-sd-longsword>)
	id 1QQPsw-0006qD-F4
	for git@vger.kernel.org; Sun, 29 May 2011 06:13:22 +1000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174674>

Hi list,

I was just looking at various versioning schemes, and I came to wonder
about git's one.  Most of the ones out there are of the form
<major>.<minor>.<optional revision> (j.n.r), but git seems to have four,
as in 1.7.5.1.

So, I was wondering what you call each number in the git version; does
the usual j.n.r apply to the last three and the first one is a
"mystery"?  What is the official versioning scheme?  Does each number
have any particular name?


Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments
