X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] cgit 0.1
Date: Thu, 21 Dec 2006 01:37:48 +0100
Message-ID: <8c5c35580612201637t505bb2f0nbed0f2ace875deae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 21 Dec 2006 00:37:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OHch9J4PDbkZjLvska7+UGRVa/YjVnWZfNDGDNW2Md5q5n5j0TDZea/L4H1ZOnWzyS4/pOVvm71bbXLmQIIgbsv3ANL99eTs6GBWfklCDELNvdboG6wG3s3qzT9CwX5zzbpLQvWitgUcuQbqEm1OSPErKuJdFo044VBbLvenOUg=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34989>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxBwY-0001sc-DB for gcvg-git@gmane.org; Thu, 21 Dec
 2006 01:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161120AbWLUAhv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 19:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbWLUAhv
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 19:37:51 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:47235 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161120AbWLUAhu (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 19:37:50 -0500
Received: by an-out-0708.google.com with SMTP id b33so713490ana for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 16:37:49 -0800 (PST)
Received: by 10.78.200.3 with SMTP id x3mr37592huf.1166661468502; Wed, 20 Dec
 2006 16:37:48 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Wed, 20 Dec 2006 16:37:48 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

  cgit - cgi for git, running on libgit.a

I've pushed out a rather usable release of cgit, available for cloning at

  git://hjemli.net/pub/git/cgit

and for (re)viewing at

  http://hjemli.net/git/cgit/


Current features:
  Page cache
  Repository listing
  Branch listing
  Log view
  Commit view
  File diff view
  Tree view
  Blob view

Todo:
  Tag list
  Snapshots
  Usability


Enjoy!

-- 
