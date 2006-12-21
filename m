From: "Joseph Carrafa" <carrafaj@gmail.com>
Subject: git-svn question
Date: Thu, 21 Dec 2006 12:34:30 -0500
Message-ID: <f2e8061d0612210934m2f147a1bl55d7152cc85f6f3e@mail.gmail.com>
References: <f2e8061d0612210927p2d18adb4u995ce16702fc3b08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 18:34:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxRoV-0003A4-OW
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 18:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWLURec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 12:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWLURec
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 12:34:32 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:4014 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422988AbWLURec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 12:34:32 -0500
Received: by an-out-0708.google.com with SMTP id b33so772064ana
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 09:34:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cjxC4G0NoLhc1PWJWgOKeshpZpbEV6tseKCnMlcCCdmo7FDmrgLXf1Yq3tEInaRZ9cwU9CCnb0XuMrbVMXSc9v/a1y35Fo99wP7swiC+m5/hdRamzOZPajZleiRKsw1daO25iqCwGVquxc5MJpLkMhC9f9sy9P/PBd/S30pnx00=
Received: by 10.78.201.2 with SMTP id y2mr686582huf.1166722470969;
        Thu, 21 Dec 2006 09:34:30 -0800 (PST)
Received: by 10.78.106.11 with HTTP; Thu, 21 Dec 2006 09:34:30 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <f2e8061d0612210927p2d18adb4u995ce16702fc3b08@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35074>

I have a question concerning using git with an svn repo.  I have a
local git repo that was created with git svn init
$SVNROOT/branches/2.2.0.  we moved the svn branch to
$SVNROOT/branches/2.3.0.  how can i change my local git repo to commit
to the new svn branch, $SVNROOT/branches/2.3.0?

Thanks
-Joe
