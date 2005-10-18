From: Morten Welinder <mwelinder@gmail.com>
Subject: 4aaa702794447d9b281dd22fe532fd61e02434e1
Date: Tue, 18 Oct 2005 11:04:18 -0400
Message-ID: <118833cc0510180804n633abe42t3d9248ed5145bf14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Oct 18 17:05:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERt1D-00032M-48
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 17:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVJRPET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 11:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJRPET
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 11:04:19 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:58937 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750771AbVJRPET convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 11:04:19 -0400
Received: by qproxy.gmail.com with SMTP id v28so1163228qbe
        for <git@vger.kernel.org>; Tue, 18 Oct 2005 08:04:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z3mWBjQZXwLJKG5Q+07ZxL1J+kDqIlJW/z9XF/BApx0tj+byz7vgTgK/KLT41Huy/6p5Py+CNXTo4TqqADfs0da2PHXRgX8FYtus2/TxuOmfD+DeJeugC7v2QqW71KbhNMcEzzHS1YE60JF2QGsRHYJUy24eVIdgHKUuZiz8Y0I=
Received: by 10.65.156.16 with SMTP id i16mr60813qbo;
        Tue, 18 Oct 2005 08:04:18 -0700 (PDT)
Received: by 10.65.107.8 with HTTP; Tue, 18 Oct 2005 08:04:18 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10215>

My "git pull" has turned unhappy within the past few days.  Ideas?

Morten


$ git pull
Fetching refs/heads/master from
http://www.kernel.org/pub/scm/git/git.git/ using http
Getting alternates list
error: The requested URL returned error: 404 (curl_result = 22,
http_code = 404, sha1 = 4aaa702794447d9b281dd22fe532fd61e02434e1)
Getting pack list
error: Unable to find 4aaa702794447d9b281dd22fe532fd61e02434e1 under
http://www.kernel.org/pub/scm/git/git.git//

Cannot obtain needed object 4aaa702794447d9b281dd22fe532fd61e02434e1
while processing commit 0000000000000000000000000000000000000000.
