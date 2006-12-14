X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 22:50:26 +0000
Message-ID: <200612142250.27766.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <20061214114546.GI1747@spearce.org> <7v4pry16n5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 22:53:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rbXZnAwIUMk577oLL8mLECtzklSM7xaB5FACnz02fudBFdqNGkVc9ew/lNWU2PI0xuYcluGEqhpZMXul9knsT+9aMPjTaZDv8iKeBRyZqVbGXtxrumhNI+ik93ld9FcjYbXZUicIzNVvMoxZx5dHl9inEQy7vnfqzkzVxXwfirA=
User-Agent: KMail/1.9.5
In-Reply-To: <7v4pry16n5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34422>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzS0-0005fP-PP for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750992AbWLNWxN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWLNWxN
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:53:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:19547 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1750992AbWLNWxM (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 17:53:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so645625uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 14:53:10 -0800 (PST)
Received: by 10.66.248.5 with SMTP id v5mr73802ugh.1166136790395; Thu, 14 Dec
 2006 14:53:10 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id e1sm3289661ugf.2006.12.14.14.53.09; Thu, 14 Dec
 2006 14:53:09 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006, December 14 21:58, Junio C Hamano wrote:

> Correct but a bad example that does not demonstrate the real
> power of reflog.  Andy's AGGGHHHHHH can be recovered with a
> simple:
>
> 	$ git reset ORIG_HEAD

HAHA!  I knew reading this mailing list would pay off.

It amazes me that there is always an answer.  It's almost becoming a 
pantomime - I say "well git can't do this", and you say "oh yes it can".


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
