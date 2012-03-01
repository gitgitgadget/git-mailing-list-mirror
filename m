From: Jakub Narebski <jnareb@gmail.com>
Subject: Google Summer of Code 2012... and git wiki
Date: Fri, 2 Mar 2012 00:27:40 +0100
Message-ID: <201203020027.41016.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 00:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3FPe-00007M-R8
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 00:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2CAX1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 18:27:43 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34178 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab2CAX1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 18:27:42 -0500
Received: by eaaq12 with SMTP id q12so417922eaa.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 15:27:41 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.47.8 as permitted sender) client-ip=10.14.47.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.47.8 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.47.8])
        by 10.14.47.8 with SMTP id s8mr4324264eeb.91.1330644461523 (num_hops = 1);
        Thu, 01 Mar 2012 15:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        bh=ODR16d690KA2GmkE9XCHUrsZqj/JDsxuFAHAACQs2Yk=;
        b=j7jnG+JvurBAAtrmna6RrQIAPuAQetJvI8qHMUfbS0Pkre0J7dsV6dTrX8BDXOHpHv
         2UV4goixhJ5TzR2eQJUS7Z1Ng+772CTPOzZMBZcDdnLe9r7JK8zuDnDnteclN2q0RkM4
         tfRthiQywxJI40cCCb0ZJGweu2ofBlUOLtkaR9tgicpIMNNGWPB9jr1o661aWqoz/2Jh
         r3e6vMFC3JCgSabOHGW3Z3GmrqFV5unQ1I+SqbTeoEoqVX/JRbFpVUxXOBegAitPAIHp
         0aG/3EYXJxerKFUg+dyPg60Bq+nZLzULCSzoamFKlZ2eTIwV1tV6giH2uNVXiIpH8PME
         IjXQ==
Received: by 10.14.47.8 with SMTP id s8mr3319302eeb.91.1330644461378;
        Thu, 01 Mar 2012 15:27:41 -0800 (PST)
Received: from [192.168.1.13] (abvz178.neoplus.adsl.tpnet.pl. [83.8.223.178])
        by mx.google.com with ESMTPS id u9sm12853607eem.11.2012.03.01.15.27.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 15:27:40 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191986>

Google Summer of Code 2012 has started. =A0The Git Development Communit=
y=20
has time till March 9 to submit organization application.

The problem (beside finding volunteer for the position of GSoC=20
administrator) is that both GSoC application and ideas for GSoC=20
projects were hosted on Git Wiki... but Git Wiki is still only parially=
=20
functional, available only as static pages under changed URLs.

I guess we can get by without having fully functional wiki for creating=
=20
application (if we decide to apply), but it would need a forum to send=20
ideas for GSoC projects and some place to publish them.  Editable wiki=20
can work as both, though git mailing list and some static page (perhaps=
=20
home pages for git project on GitHub?) could also work.


I don't know what are ETA on bringing Git Wiki fully up, but I doubt it=
=20
would be possible at http://git.wiki.kernel.org -- it is more than two=20
months since the event and wiki is not functional yet.  Perhaps it=20
could be hosted at git-scm.com somewhere -  but it really should be=20
true wiki, editable without need to use git.

--=20
Jakub Narebski
Poland
