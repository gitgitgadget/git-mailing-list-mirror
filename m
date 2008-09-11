From: dhruva <dhruva@ymail.com>
Subject: Re: PATCH: git-p4 optional handling of RCS keywords
Date: Thu, 11 Sep 2008 12:43:28 +0530 (IST)
Message-ID: <269721.95776.qm@web95004.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>,
	GIT SCM <git@vger.kernel.org>,
	Jing Xue <jingxue@digizenstudio.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 09:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdgNz-0004Lr-K3
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 09:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbYIKHNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 03:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbYIKHNc
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 03:13:32 -0400
Received: from n1a.bullet.in.yahoo.com ([202.43.219.18]:27141 "HELO
	n1a.bullet.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751797AbYIKHNb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 03:13:31 -0400
Received: from [202.86.4.170] by n1.bullet.in.yahoo.com with NNFMP; 11 Sep 2008 07:13:28 -0000
Received: from [203.104.18.53] by t1.bullet.in.yahoo.com with NNFMP; 11 Sep 2008 07:13:28 -0000
Received: from [127.0.0.1] by omp105.mail.in2.yahoo.com with NNFMP; 11 Sep 2008 07:13:28 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 466727.85375.bm@omp105.mail.in2.yahoo.com
Received: (qmail 97927 invoked by uid 60001); 11 Sep 2008 07:13:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=2HQYwuV2TF5ZwYKFsZJ0Yz1GwFBGuPS/phLHuTSHN0v53FZxK6MXaqwqi+6gXi56HoP1EC+NNgMgIk7Mbo2mQtWnw4EXYG9k8ZyGJTIROaR4+cjCSf9IqlfuwfpsWvhHiyijptGWdjJLpSx/YRjm10K+0nizBQxs50NyR5SPZZA=;
X-YMail-OSG: _kTFTI0VM1mTgbmR0Rup.rMRBjy_vW2a3zk7X.4UVrVFrPXc1SbrSUP1yIUWk6h6HBYNkbYoII4XX4zq5YfOxZYN0iOi1jUeUlra1f8Ed.XPFMUxZay26ANhyGbNE4w-
Received: from [202.3.112.9] by web95004.mail.in2.yahoo.com via HTTP; Thu, 11 Sep 2008 12:43:28 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95588>

Hi,


 The patch I have sent is 1 single patch.


----- Original Message ----
> From: Tor Arvid Lund <torarvid@gmail.com>
> To: dhruva <dhruva@ymail.com>
> Me guesses that Junio (who gets loads of patches) would be happy if you do:
> 
> 1) Squash these changes down to one single commit
> 2) Run git format-patch -1
> 3) Send it to the list either with git send-email, or otherwise send
> the 0001-.patch to the list directly if your
> mailer supports it.

Let me start learning that now. I have added my own extensions on top of what I have submitted, I need to figure out a way to do all these stuff (I am still a newbie to git ;)

-dhruva



      Get an email ID as yourname@ymail.com or yourname@rocketmail.com. Click here http://in.promos.yahoo.com/address
