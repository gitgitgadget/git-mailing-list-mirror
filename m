X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: How to conver no branches/tags svn repo to git ?
Date: Thu, 7 Dec 2006 21:31:12 +0800
Message-ID: <4b3406f0612070531p13611c68lf65a172c5e4e7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 13:31:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QClG2QUM1iAGeV+WOgt3W1ZZ+ppxAiLK/k/w7jLg00AdYeKGJYFCrMPCSy39/xt5Tnb1RFiAWyLrzFp8feZ58aQdMoapDcanTIFC6O8W3KiML74GjOL/DPAL4tN1UhRH9KSuka9Q1zUEHAYortrc+KEe+uWiTj8tAZw52mQur68=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33576>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsJLJ-0006N6-KU for gcvg-git@gmane.org; Thu, 07 Dec
 2006 14:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032205AbWLGNbP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 08:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032208AbWLGNbP
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 08:31:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:18997 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1032205AbWLGNbN (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 08:31:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so462893uga for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 05:31:12 -0800 (PST)
Received: by 10.78.83.13 with SMTP id g13mr1399876hub.1165498272021; Thu, 07
 Dec 2006 05:31:12 -0800 (PST)
Received: by 10.78.165.2 with HTTP; Thu, 7 Dec 2006 05:31:11 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

e.g.
http://svn.berlios.de/viewcvs/open-iscsi/
http://svn.berlios.de/svnroot/repos/open-iscsi

Can I convert / to master simply ?

