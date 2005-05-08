From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Pointers to CVS 2 GIT imports and gateways
Date: Mon, 9 May 2005 11:16:16 +1200
Message-ID: <46a038f90505081616335c2a61@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon May 09 01:09:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUute-0008M0-5J
	for gcvg-git@gmane.org; Mon, 09 May 2005 01:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVEHXQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 19:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVEHXQT
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 19:16:19 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:60877 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263001AbVEHXQQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 19:16:16 -0400
Received: by rproxy.gmail.com with SMTP id j1so639870rnf
        for <git@vger.kernel.org>; Sun, 08 May 2005 16:16:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M20oHv9cS4cLf3rkx9UWXiVC/15dc7eml0CEVoaUMOZSLxo3QTZYriYZrfVZZA6VEw9TbI2MJO75Oe06POxthCCI6jmRE3EiivhZ1b9212J75AoLRziwFYvwifcmkgWlsB90/bTPMXjikpUDVqGg63mPCyTBkgYcqSjoe7BctEc=
Received: by 10.38.150.24 with SMTP id x24mr1238366rnd;
        Sun, 08 May 2005 16:16:16 -0700 (PDT)
Received: by 10.38.101.1 with HTTP; Sun, 8 May 2005 16:16:16 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am looking into importing a cvs repo HEAD history into git using
cvsps. I read throught the thread where Ingo discussed his import of
the kernel sources, but I couldn't find any pointers to what kind of
shell magic or other associated scripts were used, and google hasn't
helped much either.

How do I feed the patchsets into GIT preserving commit msgs and other metadata?

A related question follows: is anyone running git -> cvs gateways, and how? 

pointers to TFM will be much appreciated ;)

cheers,


martin
