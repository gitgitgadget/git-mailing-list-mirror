From: Steven Michalske <smichalske@gmail.com>
Subject: Ignoring remote branches.
Date: Tue, 11 May 2010 00:40:43 -0700
Message-ID: <9F4F3DE1-59FE-4D27-A40E-81856BF95C9D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 11 09:40:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBk5H-0006k5-LP
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 09:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab0EKHkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 03:40:49 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:63206 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0EKHks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 03:40:48 -0400
Received: by pzk42 with SMTP id 42so589803pzk.4
        for <git@vger.kernel.org>; Tue, 11 May 2010 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:content-type
         :message-id:date:to:content-transfer-encoding:mime-version:x-mailer;
        bh=SXXaYfOgHnPR+c05QN1VavQmH6rWTnZXek6gh4rLPng=;
        b=vZRZ52xvPXaCydAg3xeINhBgcUBuvW+ZzA0L+9vZRWHgPp/PEkM0Y7PnODHl8S1eJK
         qZ1rr9pIpYwsa3p24GIeXB8Z+XyzrVyETnPnZ3f9hjSsJ/vD1XGSeNk5xjic1WsEyD/+
         SCH8JO1NIk5/I719kETf1pUsGQ+SGoKwFcdPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:content-type:message-id:date:to
         :content-transfer-encoding:mime-version:x-mailer;
        b=wM2Y6lR+nlVEmdlTqJu8gaa1GNVPTq+5x/AGy7SAO3EvWL6/MyuPzEU3t/iP5F76RE
         Uw2CuxXzsgWUwRfEluMV5UyjUxqWiS1XopJ9KQXySx5HMVDNjJbguVMRZZkAb/fAjGrU
         ikWBq3PA4U0VOep42LkjOLmIS9BWpICOGVOXs=
Received: by 10.141.14.21 with SMTP id r21mr3526703rvi.144.1273563647187;
        Tue, 11 May 2010 00:40:47 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id i19sm2594258rvn.11.2010.05.11.00.40.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 00:40:45 -0700 (PDT)
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146877>

Howdy,

I would like to know a way to exclude fetching stacked git branches  
from repositories.

But I want to track new branches, so specifying the branches I want to  
fetch is tedious.

Any workarounds to ignore all branches that match *.stgit

Steve
