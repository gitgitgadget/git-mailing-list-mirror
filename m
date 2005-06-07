From: Jon Seymour <jon.seymour@gmail.com>
Subject: Question: mode on git-resolve-script - it's intentionally non-executable, right?
Date: Wed, 8 Jun 2005 02:04:56 +1000
Message-ID: <2cfc4032050607090420146ee0@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 09 12:16:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgIcl-00006W-0C
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 10:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVFIIqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVFIIqu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 04:46:50 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:15526 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261540AbVFIIqt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 04:46:49 -0400
Received: by rproxy.gmail.com with SMTP id i8so41477rne
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 01:46:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZB85Cbdl4QQEjVbaiv/RccZzkYZcrE2EUPnueyY6WnFJAdIYnIr1x95BbWKapZNh7FjXc8SRWANADbOnTKp63eQRlAZxJhaPVSgc7f9Z4MwGnWyunU3fIhLwMYYClRPB/CpH5j62QysKLXv+vUJ1zFpYLbXeEnjf2yv2Y0vAJ6I=
Received: by 10.38.203.29 with SMTP id a29mr3189684rng;
        Tue, 07 Jun 2005 09:04:56 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 7 Jun 2005 09:04:56 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Can someone confirm that the mode on git-resolve-script is
intentionally non-executable, so as to prevent glitches when git is
used to maintain git?

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
