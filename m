From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: gitweb commitdiff output error
Date: Thu, 28 Sep 2006 15:20:01 +0800
Message-ID: <4b3406f0609280020m43695511qb5da5a3394ad6417@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 28 09:20:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSqBk-0006dL-Hh
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 09:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWI1HUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 03:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWI1HUE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 03:20:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:4572 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751723AbWI1HUC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 03:20:02 -0400
Received: by py-out-1112.google.com with SMTP id n25so629819pyg
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 00:20:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CNVHZOlAorZ8mzwNRhQ38EwguhFtuMp4H8CVvENsbNF46WDu8Nk46RhmyOanK4WqUzeIOsw7L2Epi1s/8AeupGIvBTxUmIOWAJ4V88CXqn0h2KfDdhwFHxozGt818Gc2A6NaE5A/lD1EzaEmJWPkIgapVQpSDBSQFBwL16x1gTk=
Received: by 10.35.121.12 with SMTP id y12mr3175746pym;
        Thu, 28 Sep 2006 00:20:01 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Thu, 28 Sep 2006 00:20:01 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27991>

Hi,

When the file enconding is not utf8, the gitweb commitdiff output
error for non-ascii characters.

Can I do iconv for commitdiff  ?

Dongsheng
