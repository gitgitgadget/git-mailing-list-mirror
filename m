X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Matt McCutchen" <hashproduct+git@gmail.com>
Subject: How to view an old revision?
Date: Wed, 1 Nov 2006 09:20:52 -0500
Message-ID: <3bbc18d20611010620m11e40402v44334a8c486a4932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 14:21:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=FpjiTWTRpEEvjeiw0VG256777MqDAs7IVWIA45okql1JHFrnXfVPcwmuZOfnRUMpyq7PnDm8wkTmUv6hk4nwPbMVfNtZbvlE6ZY9MQ1EoaBngnoeXjIbPDLSzaBSc85q7XOPLVLTmftu8sdNem8yc/j8LfH/WZl5pTU3ojRwXRY=
Content-Disposition: inline
X-Google-Sender-Auth: eb03db6d8375b1c7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30638>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfGxm-0006FJ-0t for gcvg-git@gmane.org; Wed, 01 Nov
 2006 15:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946895AbWKAOUz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 09:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946897AbWKAOUz
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 09:20:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:58887 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1946895AbWKAOUy
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 09:20:54 -0500
Received: by nf-out-0910.google.com with SMTP id c2so847799nfe for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 06:20:53 -0800 (PST)
Received: by 10.82.106.14 with SMTP id e14mr1488387buc; Wed, 01 Nov 2006
 06:20:52 -0800 (PST)
Received: by 10.82.129.2 with HTTP; Wed, 1 Nov 2006 06:20:52 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Dear git people,

How do I view an old revision of a file without actually checking it
out?  This would be analogous to "cvs checkout -r <old> -p".  I've
RTMed and STWed and can't seem to find a way.

