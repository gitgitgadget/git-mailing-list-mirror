X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Mitch Bradley <wmb@firmworks.com>
Subject: Seeking git recipe to grab a single file
Date: Wed, 06 Dec 2006 11:22:22 -1000
Message-ID: <4577348E.4090105@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 21:27:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33523>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs4IL-0001tg-Pt for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937649AbWLFV0x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937663AbWLFV0w
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:26:52 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:39165 "EHLO rs27.luxsci.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937649AbWLFV0v
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 16:26:51 -0500
Received: from [10.20.0.14] (user-10cm75o.cable.mindspring.com
 [64.203.28.184]) (authenticated bits=0) by rs27.luxsci.com (8.13.7/8.13.7)
 with ESMTP id kB6LQnPn032181 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NOT) for <git@vger.kernel.org>; Wed, 6 Dec 2006 15:26:50
 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I want to grab a single file from a remote git repository into the 
current directory, which is not a git tree.  Is there an easy way to do 
that?  I have tried using git-fetch and git-cat-file, without success.

Thanks,
Mitch Bradley
