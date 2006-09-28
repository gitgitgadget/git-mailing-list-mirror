From: apodtele <apodtele@gmail.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 12:50:09 -0400
Message-ID: <d620685f0609280950v1eccefe2q1e5dea4fb7350638@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 28 18:50:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSz5U-0003FD-PV
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWI1QuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWI1QuM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:50:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:58343 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751931AbWI1QuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:50:10 -0400
Received: by wx-out-0506.google.com with SMTP id s16so595863wxc
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 09:50:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OQda5wMMfeXsI7wcBORDAppL2DUA04j/mEzdr+ZcEZfZsH0fYFmrCSXI9RGtWdvFFg/xtEiZ8lzqHFUK/aEmGl4rMjpoyjaw8xvCXRTkQ9KPyNmmkEmwB4n396iY5O0yu5y9ed2aCRljtFt4ByjzVvOCIZ3yA35+c0ojroO5q8Y=
Received: by 10.90.81.14 with SMTP id e14mr925547agb;
        Thu, 28 Sep 2006 09:50:09 -0700 (PDT)
Received: by 10.90.94.11 with HTTP; Thu, 28 Sep 2006 09:50:09 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28018>

Matthew wrote:
> No. I merely think git should try harder to ensure that commit order is consistent
> with time order

Matthew doesn't seem to grasp the idea that commit order is
conceptually MORE fundamental than time, NOT LESS. Hence, the time
shall not dictate the order for git. If anything, git may try harder
to ensure that time is consistent with order, not vise versa. :)
