From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: request for pre-generated git.info pages
Date: Wed, 29 Oct 2008 18:00:45 -0400
Message-ID: <ee2a733e0810291500o67b3f94fibef63e0a173e8cc1@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 23:02:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvJ73-0006P0-EN
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 23:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYJ2WAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 18:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYJ2WAs
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 18:00:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:15354 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYJ2WAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 18:00:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so208570fgg.17
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=eZQor9b43oPYaJQSOuWEu0v2vXYu1Sx1QCljTSxO3SE=;
        b=lDIzFIW42BDO5WPpbcdTJ3n1Z+gPZ3lUiNRs1AwJJR6Y8mpd1lqCgOMl4IvDp5DZUp
         i1woJYCPVu7g9VERCLs4qO6BfrLjnUGKGo86EbSYt9XkTuSHTobDwpl+Rku1kIaeg/Vc
         KtbIxTbnfs9IYV4Nqhwnb5a4u7C2xxMMEsbiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=h57rO5E4RgOmxF5H6ITB5ZvPU/EX+j1zcW/3jSA7SirIu0Wh4KqA+LpCAshGmLJUfS
         TUDNBeKcVLXr3ED8sagBktYJgbsq+3oqoWdSLJAy9cPhy8EmV/1+N5PavuNSAwDhX7Nk
         c9NmojYW05us8W7gHMfRGnhPpWPKM/mIOE2Ag=
Received: by 10.181.240.7 with SMTP id s7mr2514647bkr.110.1225317645607;
        Wed, 29 Oct 2008 15:00:45 -0700 (PDT)
Received: by 10.181.7.8 with HTTP; Wed, 29 Oct 2008 15:00:45 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99418>

I am an emacs user but with my current setup I have difficulties
generating git.info pages. Main Git repo already provides
pre-generated man and html  documentation in "man" and "html"
branches. I would kindly beg to extend this privilege to "info" pages
to benefit all the emacs users out there.

--Leo--
