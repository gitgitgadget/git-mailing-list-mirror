From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Modifying RCS keywords prevents submitting to p4 from git due to missing hunks. Optional shrinking of RCS keywords in git-p4. New option git-p4.kwstrip set to true or false controls the behavior
Date: Mon, 15 Sep 2008 11:32:54 +0530 (IST)
Message-ID: <640112.28035.qm@web95015.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: GIT SCM <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Sep 15 08:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf7Bu-0005HP-M8
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 08:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbYIOGC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 02:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYIOGC6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 02:02:58 -0400
Received: from n2b.bullet.mail.in2.yahoo.com ([203.104.19.41]:39129 "HELO
	n2b.bullet.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751187AbYIOGC5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 02:02:57 -0400
Received: from [202.86.4.171] by n2.bullet.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 06:02:54 -0000
Received: from [203.104.18.52] by t2.bullet.in.yahoo.com with NNFMP; 15 Sep 2008 06:02:54 -0000
Received: from [127.0.0.1] by omp113.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 06:02:54 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 738325.21908.bm@omp113.mail.in2.yahoo.com
Received: (qmail 28446 invoked by uid 60001); 15 Sep 2008 06:02:54 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ayw5hiHIo0ON95MDlERgyNcoGkdKoJuwIDyrkQibsYWDwdedHYb8GGQqnng2geue23yGYAsukCNq5YdrMFXU6ioHGu+6ooBXtm7uYnaF07ATy7pHTC+YxbnUu3bHFq/hTamICIchf+LPjztcM78ZLe+MhBTA0asZEcdVswTiQBw=;
X-YMail-OSG: ZUul4QEVM1l5k0Sj1Z.yHYnxhXjR6F8YGMr_cujgHBL05wZ7Wo_39ysQc_JYN_6Maa2Y4csP6NDnQYAVxMQ8J0eMMmQmu46TTLRqcRJooLVRSoQwDW3jkoQYcbZNRjU-
Received: from [202.3.112.9] by web95015.mail.in2.yahoo.com via HTTP; Mon, 15 Sep 2008 11:32:54 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95877>

I had a real tough time configuring 'git send-email'. Looks like I finally have something working... I am still finding it tough to handle identity. I am figuring it out now by trial and error (with more errors) basis

-dhruva



----- Original Message ----
> From: Sverre Rabbelier <alturin@gmail.com>
> To: Dhruva Krishnamurthy <dhruva@ymail.com>
> Cc: "GIT SCM <git@vger.kernel.org>, Junio C Hamano" <gitster@pobox.com>
> Sent: Monday, 15 September, 2008 10:24:37 AM
> Subject: Re: [PATCH] Modifying RCS keywords prevents submitting to p4 from git due to missing hunks. Optional shrinking of RCS keywords in git-p4. New option git-p4.kwstrip set to true or false controls the behavior
> 
> On Mon, Sep 15, 2008 at 06:16, Dhruva Krishnamurthy wrote:
> >
> > Signed-off-by: Dhruva Krishnamurthy 
> 
> I think something went wrong here, yes? The current title is way too
> long, and there is no commit message, perhaps you meant to put (part
> of) the title in the message instead?
> 
> "[PATCH] Modifying RCS keywords prevents submitting to p4 from git due
> to missing hunks. Optional shrinking of RCS keywords in git-p4. New
> option git-p4.kwstrip set to true or false controls the behavior"
> 
> -- 
> Cheers,
> 
> Sverre Rabbelier



      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08..html/
