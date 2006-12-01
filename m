X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 00:01:54 +0000
Message-ID: <200612010001.57111.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301530.51171.andyparkins@gmail.com> <20061130163304.GN12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 00:04:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G1AQCuStt75cF4lkQFUE3Hbc+SsYtg/Z45qjfhQ6kDJLaxzhJj3zqf8BKkkeYzHuvJ5hd6Rzo3WOAqgx0Q5IHKvmPSXNSufIvWaAfSYJSFjRc3ePlenESBHjocoK28L/w9Wfa3ASB0+lbP/0zLFBe+fq+br47+x0N8wd8+3N76w=
User-Agent: KMail/1.9.5
In-Reply-To: <20061130163304.GN12463MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32835>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpvtX-0001K5-Cn for gcvg-git@gmane.org; Fri, 01 Dec
 2006 01:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967997AbWLAAEp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 19:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967998AbWLAAEo
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 19:04:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:48407 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S967997AbWLAAEn
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 19:04:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2278352uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 16:04:42 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr6382687ugh.1164931482244; Thu, 30
 Nov 2006 16:04:42 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 32sm24517340ugf.2006.11.30.16.04.39; Thu, 30 Nov
 2006 16:04:39 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006, November 30 16:33, Sven Verdoolaege wrote:
> > Well, I know what the commit is /that/ was all that was stored.  So I
>
> Then I have no idea what you are talking about.
> A commit _contains_ all the history that lead up to that commit,
> so if you have the commit, then you also have the history.

It's not so much an actual commit, as a reference to a commit in another 
repository.

Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
