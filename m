X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 11:23:01 +0000
Message-ID: <200612141123.02346.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612141021.12637.andyparkins@gmail.com> <Pine.LNX.4.63.0612141147200.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 11:23:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T01CWLWAJFciPTXEesZrwYsASM/XB+P123zceoUOAM4GjHikPbGalBpRY4c6Wx7+tDBnkbuIXWNWi4LX5Z/Gg24vKGsuvzQAzIi26CtVEEGlhQOW2Nr0YJ8LN2msjdkrtv5Jz52ni5cTVpKDN9Gmw2zB2EGwAgXccLyMQIanCuY=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612141147200.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34317>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuogC-0004kO-A7 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932566AbWLNLXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWLNLXJ
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:23:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16125 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932621AbWLNLXI (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 06:23:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so465091uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 03:23:07 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr1214010ugi.1166095387291; Thu, 14
 Dec 2006 03:23:07 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm1834400ugd.2006.12.14.03.23.05; Thu, 14 Dec 2006 03:23:06 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 10:51, Johannes Schindelin wrote:

> If I have the choice between a "doing something" bar and a Windows
> Explorer "14 seconds left" bar showing the same message for two minutes,
> I'd rather have a Mars bar ;-)

Gahhhhhhhhh!  Oh how I hate that window.

On this we can wholeheartedly agree.  Unfortunately it's not just windows; 
most applications that have a progress bar go like this:

0%, ..., 0%,..., 0%,.., 1 , 2, 3, 4, 5, 6, 33%, ..., 33%, ..., 33%, 35, 36, 
85%, ..., 85%, ..., 85%, ..., 99%, 100%, ..., 100%, ... (yes, I'm completely 
finished, but still working), ... 100%.

I reckon, unless the window with a progress bar in it has an ETA, then the 
progress should be an ETA itself.  If it's not going to monotonically 
increase, then the "percentage" is meaningless.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
