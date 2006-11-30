X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 18:25:09 +0700
Message-ID: <fcaeb9bf0611300325r3a3fa8av141359c69d2377b5@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca> <456CB197.2030201@onlinehome.de>
	 <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
	 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>
	 <456DD76C.4010902@gmx.net>
	 <Pine.LNX.4.64.0611291235590.3513@woody.osdl.org>
	 <87bqmpvlxf.wl%cworth@cworth.org> <456E8147.9070304@gmx.net>
	 <Pine.LNX.4.63.0611301111310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 11:25:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZX8dtlIa9dQi2j4mFvGCyN2TuB9vSd8gkwJdlr0W0fQHMKcGTLNrTEjVDf+TMRmkUo80qq8PIPR7ROstybFPVAffn/gZKZ3+plRutUaP9qDQfnfgJCEwL9hpj7+UC+Es0Ryc8vvlWZKNP7RlhPRnvrLBhZHyx1tY+8WwcRzmgUQ=
In-Reply-To: <Pine.LNX.4.63.0611301111310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32723>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpk2Y-0003M3-R7 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 12:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933924AbWK3LZO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 06:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759249AbWK3LZN
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 06:25:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:2055 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1759248AbWK3LZL
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 06:25:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2079670uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 03:25:10 -0800 (PST)
Received: by 10.78.128.11 with SMTP id a11mr3400421hud.1164885909660; Thu, 30
 Nov 2006 03:25:09 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 30 Nov 2006 03:25:09 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 11/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> But here's an idea: tell the user that she has to tell git-commit which
> files she wants committed. Yes! That's it. Just tell it the friggin'
> files. And if you are a lazy bum, and want to commit _all_ modified
> files, git has a nice shortcut for ya: "-a".

It reminds me Microsoft Office Assistant :-) Let's make "git assistant
mode" that tries hard to guess user's desires and give them guidance.
Once they get used to git, they can disable that mode and back to
"plain git".
-- 
