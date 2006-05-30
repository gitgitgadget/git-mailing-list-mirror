From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: git --version
Date: Wed, 31 May 2006 00:16:30 +0200
Message-ID: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 31 00:16:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlCVv-00024k-Jj
	for gcvg-git@gmane.org; Wed, 31 May 2006 00:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWE3WQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 18:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWE3WQc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 18:16:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:28338 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964773AbWE3WQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 18:16:31 -0400
Received: by wr-out-0506.google.com with SMTP id i21so773836wra
        for <git@vger.kernel.org>; Tue, 30 May 2006 15:16:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hbrVUaq4EVrFX2lhHalMNWNIxsspYCcqjkuceOhqPTTjToKRAkkGGAYJH807smgJZdRK4uAIlX4CiLCrCYUE3HOuPJiWb5jluaFLUyXCymbCdYcO0e1qGbLFVyE77DiQTR9qI89XuzqUaMfQVq+HDFLwTBTy6LUug25/KdUYOOE=
Received: by 10.64.76.10 with SMTP id y10mr2361466qba;
        Tue, 30 May 2006 15:16:30 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Tue, 30 May 2006 15:16:30 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21045>

Hi all,
I'm confused by the following:
paolo@Italia:~/git$ ./GIT-VERSION-GEN
GIT_VERSION = 1.3.3.g2186

paolo@Italia:~/git$ git --version
git version 1.3.GIT

Why git --version is not reporting the "full" version number?

Thanks.

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
