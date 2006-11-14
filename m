X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: tracking separate branches with RSS
Date: Tue, 14 Nov 2006 03:21:58 +0100
Message-ID: <200611140321.58749.jnareb@gmail.com>
References: <ejb3hh$nvr$1@sea.gmane.org> <ejb410$nvg$1@sea.gmane.org> <455920EC.7060804@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 02:21:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jLxNBOA9leY5bm/+bwCBHVC4J6BX3b2NLKRm8iCHmte/HiHUkX5HcLMvLZttQxHyADFLxLvGIdJwuvqie6we1XpIvRcxlSlqooBzEwj+/Erb/2oR5fiojcKh3rItxPoc0sdD6AiH2pHovQxcs/tZokucy9hHkozr0tCONO+a/mc=
User-Agent: KMail/1.9.3
In-Reply-To: <455920EC.7060804@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31333>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjnv2-0001ar-3O for gcvg-git@gmane.org; Tue, 14 Nov
 2006 03:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933318AbWKNCUu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 21:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933323AbWKNCUu
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 21:20:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:46257 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933322AbWKNCUt
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 21:20:49 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1273415ugc for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 18:20:47 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr511851ugh.1163470847177; Mon, 13
 Nov 2006 18:20:47 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id j2sm6234025ugf.2006.11.13.18.20.46; Mon, 13 Nov
 2006 18:20:46 -0800 (PST)
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote;
> Jakub Narebski escreveu:
> 
>>> A second possibility -less desirable, but better than nothing- is to 
>>> have commits from all branches show up in the shortlog and the RSS feed.
>> 
>> Use "--all" as 'h' (hash) parameter.
>> 
> 
> This doesn't seem to work.  Note that I'm savannah.gnu.org, which may 
> run an older version. The quickest way to get this up and running is to 
> have real patches appear in the official release, and convince Sylvain 
> to upgrade to a better gitweb.

Sorry, I should have made more clear that it would work only _after_
mentioned changes.
-- 
Jakub Narebski
