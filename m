X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: how-to "backup" a repository
Date: Sun, 05 Nov 2006 21:46:11 -0800
Message-ID: <454ECC23.6010503@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 05:46:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30993>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgxJM-0005e5-93 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 06:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423551AbWKFFqM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 00:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423554AbWKFFqM
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 00:46:12 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:65161 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1423551AbWKFFqL (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006
 00:46:11 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 8C9EA57A6F for <git@vger.kernel.org>; Sun,  5 Nov
 2006 21:42:57 -0800 (PST)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hello,

I've been working with git for a little while, but still very
much a neophyte. One thing I'd like to do is be able to backup
my work on a server located on my network.

Currently I have cloned the Linux 2.6 tree on my personal computer
and have been backing it up by tar'ing the subdirectory with the
cloned repository and then using scp to copy it to my server.

I suspect there is a better way, probably using git itself:)

How is the typically handled?

Cheers,

