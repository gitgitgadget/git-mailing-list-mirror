X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Git and Mozilla
Date: Tue, 28 Nov 2006 01:47:28 -0500
Message-ID: <9e4733910611272247y7ef8be0fh2f1436d43a57280@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 06:47:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GDzBu2D9RstxS49abte/zEXgVNgLcQjT4/I82ZGKEkfg0CV7C4qluCTTCxhc7JUtrj7jFzVvYDBazBiMP5Q1xqG60DXlF3IL/+oKfGK/QXaSql6pARtxnKDQ37LFamA38f04RnpB6UpNuUUb1ekiaks9L2t6tgI7Zppfl3YYF7Y=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32487>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gowkf-0001xB-0c for gcvg-git@gmane.org; Tue, 28 Nov
 2006 07:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935676AbWK1Gra (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 01:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935679AbWK1Gr3
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 01:47:29 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:6311 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S935676AbWK1Gr3
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 01:47:29 -0500
Received: by py-out-1112.google.com with SMTP id a29so1245383pyi for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 22:47:28 -0800 (PST)
Received: by 10.35.125.16 with SMTP id c16mr897951pyn.1164696448455; Mon, 27
 Nov 2006 22:47:28 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 27 Nov 2006 22:47:28 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

It looks like git is out of the race for hosting the Mozilla repository.
It's going to be Bazaar or Mercurial.

http://weblogs.mozillazine.org/preed/2006/11/version_control_system_shootou.html#more

-- 
Jon Smirl
