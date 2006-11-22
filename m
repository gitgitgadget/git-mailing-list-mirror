X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: A documentation to-do list
Date: Wed, 22 Nov 2006 09:18:57 -0800
Message-ID: <f2b55d220611220918ud5071dcj2d5d23489d9d099f@mail.gmail.com>
References: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com>
	 <Pine.LNX.4.63.0611221044180.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 17:19:52 +0000 (UTC)
Cc: "Chris Riddoch" <riddochc@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uj6DqVv+sFcUsYIdJLcFhMMns5AMFdbiu66gjiogff1jN9UekekmEo15dx0fDZb55Txl9FKJRKuGY3OsvIWDC5laS++9v9b4pY/QT1byqBh7B8zd0NKXnMBm/rGU963Xfua4ZTQN92FcPtehiTtwSVtPqLMNcjngYkEYEQupRBo=
In-Reply-To: <Pine.LNX.4.63.0611221044180.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32092>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmvkm-00024F-Hl for gcvg-git@gmane.org; Wed, 22 Nov
 2006 18:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755992AbWKVRS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755996AbWKVRS7
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 12:18:59 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:43641 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1755992AbWKVRS6
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 12:18:58 -0500
Received: by wr-out-0506.google.com with SMTP id i7so81960wra for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 09:18:57 -0800 (PST)
Received: by 10.90.72.10 with SMTP id u10mr6900070aga.1164215937570; Wed, 22
 Nov 2006 09:18:57 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Wed, 22 Nov 2006 09:18:57 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 11/22/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> So, finally my request: we should _organize_ the documentation such that
> your average Joe Programmer is able to get started with git in 1 minute.

I would modify that to a sort of "choose your own adventure" alternative:
    How to use git mindlessly (branchlessly) in 1 minute, by
pretending it's CVS with funny syntax;
vs.
    How git can make you a better programmer in 1 day, by encouraging
you to think about, experiment with, and comment on interactions
between how you and others are evolving a shared code base.

Cheers,
