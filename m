From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: git-svnimport
Date: Thu, 25 Oct 2007 12:25:20 +0300
Message-ID: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 11:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikyy6-0004IQ-Ok
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 11:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbXJYJZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 05:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbXJYJZW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 05:25:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:39794 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbXJYJZV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 05:25:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so554954wah
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=0vxj/ErBi/oNVh2lf4cJ2RsWkZgCv2e8FsfxiZgdJVc=;
        b=fytrHiVj6QZr7re/2ja38db3OuOwjNQ4NnW7TVNKqvVfzhfmRgqTKKvvEXn6bid+Qvie4iLvc39LGTNSPE31oRD/UcPYFqXYPq6aLzJZVDFKhCp00TVwYdG0VZ+YQ3F6kZes/J/0c61DSl2tgn53NjLB3M3sqJG+FmgBd4tljVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Wn6xlKx0WGWINEn5/ulcIWFuJeBeVTQ3H3BcFjwu2cH9KdWr92xbwq5HQglB8LBAYGNAFfsZLlDpfgwWyKekmVyT4cwxgEoaL3yslBBt929NOeh0nQWkKerwKUxRXAoxwdORK6+HBdJOKJIDpno7oN9dCi1N+a5uTaQpl7mlYLU=
Received: by 10.115.72.1 with SMTP id z1mr1879360wak.1193304320508;
        Thu, 25 Oct 2007 02:25:20 -0700 (PDT)
Received: by 10.114.61.4 with HTTP; Thu, 25 Oct 2007 02:25:20 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: a24dfe2204e518ff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62288>

Hello all,

I was importing busybox svn repository to git but I got a connection
timeout after more than 19k commits... is there a way to continue
where the error happened or should I do it all over again ??


Thanks

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
