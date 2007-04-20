From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: "strip" the repo
Date: Fri, 20 Apr 2007 22:28:02 +0300
Message-ID: <f36b08ee0704201228v40e95ac1h8f541b14feb2cede@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 21:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeymI-0006hE-Cl
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767215AbXDTT2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 15:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767210AbXDTT2F
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 15:28:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:25327 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767204AbXDTT2C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 15:28:02 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1102421wxd
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 12:28:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LUNFSvb3TP5A8xFzlKgh2qbmoekmC2c4bMfG7thU/RWYHnRBgtwqAsSrjfh4VueqlD8aSi37ppPOK32E1meLRbf+1ZPvfn6HW9CkhTnoQoJhqcl9/D9DPilzlttYvmX3tZSiqn3objCbZFZ+Itm1SywXsZ2Ro8J+iFRMJYR6hN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Pmee2uz3PfrE5jo71ZXw+XA8PdSkjP4gzifhFxnbgYbDZ6ngE4QE3MUAK1NCs0W5lckX/loE7Kl5Cjvl3mJUCCzMSPfxx4tjGGIBRLGR6DVJ3ldEYbLwxou1PdFAyq5h3Le+aONYkILLoYP4XXtN8fkwZWLiYoe57bEqCfu1N0c=
Received: by 10.90.25.3 with SMTP id 3mr3518059agy.1177097282072;
        Fri, 20 Apr 2007 12:28:02 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Fri, 20 Apr 2007 12:28:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45124>

I am curious, if I remove all files and dirs (except .git),
and index, will it make it a valid bare repo ?
Or switching the repo from non-bare to bare is difficult ?

Thanks
Yakov
