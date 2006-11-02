X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 20:12:55 +0100
Message-ID: <454A4337.5070703@iaglans.de>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>  <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>  <4549CE2A.3010808@xs4all.nl> <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com> <454A0538.9000104@iaglans.de> <Pine.LNX.4.63.0611021559430.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 19:13:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
In-Reply-To: <Pine.LNX.4.63.0611021559430.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30762>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfi08-0001MZ-UZ for gcvg-git@gmane.org; Thu, 02 Nov
 2006 20:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752286AbWKBTNK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 14:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbWKBTNK
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 14:13:10 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:38664 "EHLO
 vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP id
 S1752286AbWKBTNI (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 14:13:08 -0500
Received: from localhost (localhost [127.0.0.1]) by
 vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 0EA3F3ED2; Thu,  2
 Nov 2006 20:12:59 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1]) by localhost
 (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tP7pNLHFazSZ; Thu,  2 Nov 2006 20:12:46 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with
 ESMTP id 950B93E6C; Thu,  2 Nov 2006 20:12:42 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 2 Nov 2006, Nicolas Vilz 'niv' wrote:
> 
>>> Use the complete output of describe:
>>> $ git show v1.4.3.3-g1e1f76e
>> this one doesn't work for me in my repository.
> 
> You need at least v1.4.3-rc1^0~69 (v1.4.2.1-g7dd45e1) for this. You 
> indicated in your email that your version is older.

strange, from time to time i have to delete the whole git repository, 
not to get stuck on old revisions. Now with a fresh repository i get a 
current revision and with this version, it works.

Thx for help
