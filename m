X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Thu, 14 Dec 2006 00:06:52 +0100
Organization: Dewire
Message-ID: <200612140006.53291.robin.rosenberg.lists@dewire.com>
References: <20061207101707.GA19139@spearce.org> <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de> <b0943d9e0612131409x4a894f72if9c4d44cfa970be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:31:15 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <b0943d9e0612131409x4a894f72if9c4d44cfa970be@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34257>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudZB-0001Su-Sq for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751743AbWLMXbK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWLMXbK
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:31:10 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13004 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1751743AbWLMXbI (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 18:31:08 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 1D918802653; Thu, 14 Dec 2006 00:00:15 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 18245-10; Thu, 14 Dec
 2006 00:00:14 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id C6608800199; Thu, 14 Dec 2006 00:00:12 +0100 (CET)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

onsdag 13 december 2006 23:09 skrev Catalin Marinas:
> BTW, how can I notify people that only pull from the http repository
> that it will no longer be updated (rather than them thinking the
> development stopped)? One solution would be to create a file with a
> meaningful name in the top dir and hope people will notice it.

If you also remove all other files, people will notice. 

