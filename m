X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 11:23:52 +0100
Message-ID: <200611201023.54146.andyparkins@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com> <81b0412b0611200206q4ded162drdc450715d7f801e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 10:24:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DH82NOYKpextd8A2ifR/b1iyO74IjEKuIAa4dzkd9AjG+M8XbbXbm9DUWA8PZCPbwGyWHCTOP0R4TsTbJqgUZ5DZHmNOKjdTqcp0Dnew2HY/nqCAQv84St1w37k92flI+8WOLEzvCPqH1W70qk98R4VNWU7kEOp1egVJH8ORZb8=
User-Agent: KMail/1.9.5
In-Reply-To: <81b0412b0611200206q4ded162drdc450715d7f801e0@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31898>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm6Jm-0007BP-GJ for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933964AbWKTKX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934013AbWKTKX7
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:23:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:10277 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933964AbWKTKX6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:23:58 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1133974ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 02:23:57 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr3047339ugj.1164018237195; Mon, 20
 Nov 2006 02:23:57 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 20sm7526215uga.2006.11.20.02.23.56; Mon, 20 Nov 2006 02:23:56 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 November 20 10:06, Alex Riesen wrote:

> remove --pretty=oneline, it is default behavior of git log.

No it's not; are you confusing it with --pretty=short?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
