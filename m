X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Using git as a general backup mechanism (was Re: Using GIT to
 store /etc)
Date: Tue, 12 Dec 2006 15:06:46 -0800
Message-ID: <457F3606.7020805@midwinter.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <Pine.LNX.4.64.0612111837210.20138@iabervon.org> <8900B938-1360-4A67-AB15-C9E84255107B@mac.com> <200612121553.37499.andyparkins@gmail.com> <457F31E6.8090701@midwinter.com> <Pine.LNX.4.63.0612122355400.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 23:06:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=rak+fEPoYiTIHs/uonCt+M6dFTlUwdKweEQUhxF/WMwtH0dM10ioyduUtLd+NmK8  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <Pine.LNX.4.63.0612122355400.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34164>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGi3-0002T5-SL for gcvg-git@gmane.org; Wed, 13 Dec
 2006 00:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964781AbWLLXGk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 18:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWLLXGk
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 18:06:40 -0500
Received: from tater.midwinter.com ([216.32.86.90]:38068 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964781AbWLLXGj
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 18:06:39 -0500
Received: (qmail 12205 invoked from network); 12 Dec 2006 23:06:39 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 12 Dec 2006 23:06:38 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> $ git pull --depth 1
>
> Though it needs a server _and_ a client supporting shallow clones, which 
> support is brewed in "next" right now.
>   

Will that actually discard old revisions that are already stored locally?

-Steve
