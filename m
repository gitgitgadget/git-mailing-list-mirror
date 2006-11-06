X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Kirill Shutemov" <k.shutemov@gmail.com>
Subject: Merge branch to directory of other branch.
Date: Mon, 6 Nov 2006 20:01:02 +0200
Message-ID: <1d592d70611061001n6d6f7aa8tbd34a45c5d968eab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 18:22:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SJwsYN5LF+PESRf9vmoxWu6PuMSXtaFT9pmeHuLGe68v/FgMlSWkw4iMjF/TxUmNdYi8H7oqhgUXthMfqMk0MMVY8a36jNcjTGLAAelXXMjpg66rrU5wJSUEbJbfAeEe+vhLRHJGv5GtIJVbA8NuWvCz7K2lvxjWGLrdge5oyr8=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31021>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh8mU-0002X5-4Q for gcvg-git@gmane.org; Mon, 06 Nov
 2006 19:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753616AbWKFSBF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 13:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbWKFSBF
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 13:01:05 -0500
Received: from nz-out-0102.google.com ([64.233.162.204]:23593 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1753616AbWKFSBE
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 13:01:04 -0500
Received: by nz-out-0102.google.com with SMTP id z3so877087nzf for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 10:01:03 -0800 (PST)
Received: by 10.65.122.20 with SMTP id z20mr8393433qbm.1162836063124; Mon, 06
 Nov 2006 10:01:03 -0800 (PST)
Received: by 10.65.183.18 with HTTP; Mon, 6 Nov 2006 10:01:02 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I have one branch with full content and other branch with one
