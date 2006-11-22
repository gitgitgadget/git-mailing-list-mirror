X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Re: Stupid Git question
Date: Wed, 22 Nov 2006 15:28:42 -0600
Message-ID: <89b129c60611221328l333d22c6o3668aef2706f92c7@mail.gmail.com>
References: <89b129c60611211331r3bb286b6re3c2c8f65ec3896f@mail.gmail.com>
	 <89b129c60611211341j71079633g53b0ec1d2e3193a5@mail.gmail.com>
	 <ejvs65$vo8$1@sea.gmane.org>
	 <89b129c60611220628l59e305b8h4d2196f7cf6498d4@mail.gmail.com>
	 <871wnvxwg4.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 21:28:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VwSl74YxrfDyDxT8dnhtQdO917ZRb4+3Vn1sCWsHRItHcMzFJqztgz78FsNDvfm984uiUvmGJpL7st+4efbgWE4kyONHjgVgPIkf9nAN1m+c4Eshg367gBvsYPnYDl+7u9ITnq1JRqfv2QArmjSyYRhKsst0Xl6A3rtmmGkTLXU=
In-Reply-To: <871wnvxwg4.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32103>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmzeC-0005q6-6Y for gcvg-git@gmane.org; Wed, 22 Nov
 2006 22:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757030AbWKVV2p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 16:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757033AbWKVV2o
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 16:28:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:20842 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1757030AbWKVV2o
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 16:28:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so300400uga for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 13:28:42 -0800 (PST)
Received: by 10.78.193.19 with SMTP id q19mr8316709huf.1164230922297; Wed, 22
 Nov 2006 13:28:42 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Wed, 22 Nov 2006 13:28:42 -0800 (PST)
To: "Carl Worth" <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Hi,

On 11/22/06, Carl Worth <cworth@cworth.org> wrote:
> On Wed, 22 Nov 2006 08:28:58 -0600, "Sean Kelley" wrote:
> > How do I add a branch to the remote repository that is visible to all
> > team members.  It seems like the git checkout -b commands just create
> > local topic branches.
>
> Just push the branch out to the remote repository. You even gave the
> command sequence to do that:
>
> > git checkout Project
> > git pull . fm-modulator
> > git push origin Project
>

One other question - how do you rename a branch on the remote
repository once you have created it?

Thanks,

Sean

> -Carl
>
>
>


-- 
