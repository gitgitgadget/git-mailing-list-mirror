X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 16:34:51 +0000
Message-ID: <200612141634.54616.andyparkins@gmail.com>
References: <200612141519.44294.andyparkins@gmail.com> <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de> <200612141625.08485.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:35:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WlADewIoDKkdvB111DdmXdbGtkakGJOMxQaoqycKN3Z90YVawcB3GzIkyPl0WacHQyQ4xUgJG6Fc75DHYerkLfxyaWRKZPppILzDoLgpxA1cb2tWiwBm9uMDjyYfETdp4lmh5vzbpj2Xis3epvGW9kYFKjK1otRBZpMe5FyBv14=
User-Agent: KMail/1.9.5
In-Reply-To: <200612141625.08485.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34366>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutY3-0008GJ-0J for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932862AbWLNQfE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932860AbWLNQfD
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:35:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:44026 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932862AbWLNQfB (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 11:35:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so547699uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 08:34:59 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr1675936ugm.1166114099762; Thu, 14
 Dec 2006 08:34:59 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id p32sm2252263ugc.2006.12.14.08.34.58; Thu, 14 Dec 2006 08:34:58 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


> > have a convention here than configurability. You would not want "git" to
> > be called "guitar" for some users, just because they happen to like that
> > name more, either, right?
>
> You're correct; but we're talking about branch names not program names.

And the analogy is flawed.  I don't want git to be called guitar, however I'd 
be very upset if I got
  
 $ mv git guitar
 Error: git is conventionally called guitar


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
