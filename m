X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 7 Dec 2006 17:49:15 +0000
Message-ID: <200612071749.17849.andyparkins@gmail.com>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 17:52:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kzXFryU1eVO3MCOELvNzrjkjNBY1mBIK2ZnzOHBfvaYsKo1qQj0/kUz3d4N6mL21IWhMh76ZPoxEPeG8rTmOv7h9p+FwYbO3NAU5wllfAjPXqQCkuy1qV7pqCqvhAkP1GkfyWMInBaVq8hZpajiEXtKNudcy3NLtLa2Eq4OWyT0=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33602>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsNPr-00071h-Jn for gcvg-git@gmane.org; Thu, 07 Dec
 2006 18:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162595AbWLGRwM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 12:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162597AbWLGRwM
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 12:52:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:37770 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1162595AbWLGRwL (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 12:52:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so531743uga for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 09:52:08 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr3365131ugm.1165513928013; Thu, 07
 Dec 2006 09:52:08 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 54sm1332427ugp.2006.12.07.09.52.06; Thu, 07 Dec
 2006 09:52:07 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, December 06 23:42, Johannes Schindelin wrote:

> > * js/shallow (Fri Nov 24 16:00:13 2006 +0100)
> >
> >  Probably with a better documentation of its limitations and caveats,
> >  this should be mergeable to 'master'.
>
> The more I see the missing reaction, the less sure I am this is a sensible
> thing to do.

Don't be too downhearted.  I am certainly looking forward to using shallow 
clones; but by their very nature they are going to be used on big established 
projects (otherwise why would one need a shallow clone?), so until those 
projects upgrade their servers the news will be quiet

Also; it's probably going to be casual developers that find shallow clones 
useful, as the main developers will clone the whole repository.  This might 
also mean that they aren't going to be around on the git mailing list.

I certainly wouldn't say that the shallow clone work is not being appreciated.  
It's just being appreciated quietly.


Andy


-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
