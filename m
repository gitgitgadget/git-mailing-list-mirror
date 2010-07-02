From: Sabyasachi Ruj <ruj.sabya@gmail.com>
Subject: Git checkout: difference in behavior and what is in the documentation
Date: Fri, 2 Jul 2010 11:00:59 +0530
Message-ID: <AANLkTil4LcA0F5FEeoKOnR7Ko_gEpMHD_HCi3FPTG55D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 07:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUYqW-00012Q-9v
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 07:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab0GBFbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 01:31:21 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52108 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab0GBFbU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 01:31:20 -0400
Received: by qyk35 with SMTP id 35so202737qyk.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=k8svrbClcLARze1Nn9RhHKiKX2Pcc0c+dMLby8GOMKE=;
        b=bMyhGzM/ZL9jDpC9jVsWuwDkOALwRpKBhq6O0BMX3f0aDuHeMWNJv+ytTeK1syRVVj
         7Jy5sBmD40+tk4tYJwAbmoEeU6pgCCFoV5GRmaQoVTGYzDGZHYzvDwJrluwfVNl0q3tv
         sLcHY0xysUjtC0+n1XsIg9c1iC6Hj9QZ+wbLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=enwCw2J8eZhLPn/3Kv3zVE8lUvSQmTgxmqaSG/yxtzwUfsP5zix4Y3CjSh6i/LZDaD
         kst0Jlr6MGE+ClOW9n9GUdcVDuLRsL48XO2SINPl+kM2bhe42kjNz1DF20cKHn4qmpHM
         OfaK2U6aUCxqsjExXvZJt7t0yx314wcTe0Yn4=
Received: by 10.224.63.220 with SMTP id c28mr63798qai.360.1278048679211; Thu, 
	01 Jul 2010 22:31:19 -0700 (PDT)
Received: by 10.229.241.149 with HTTP; Thu, 1 Jul 2010 22:30:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150108>

I've asked the question in detail in Stack Overflow:

http://stackoverflow.com/questions/3163325/confusion-about-git-checkout

Even if there is no bug in the git behavior, I think the documentation
should be more clear.

-- 
Sabyasachi
