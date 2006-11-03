X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/4] Rename remote_only to display_mode
Date: Fri, 3 Nov 2006 13:37:33 +0100
Message-ID: <200611031237.35290.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <454B1F3B.1020603@op5.se> <7v4ptgagth.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 12:38:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qLngV8q9wqO/WFrbO8WscjnuUqX6fUvd9KiicYNTHty6OhXbv9b1+Z3Od6aVAaLFTRpyL3Ia1+NjbF/gHEgPkd8ZvQ/EW97024ddwZV+CR787JtfABG7sUtsNcw7F0I5kvQ8CJiyXXyT90qWIbczF4L01s2uqECrBEcJwv1cDU8=
User-Agent: KMail/1.9.5
In-Reply-To: <7v4ptgagth.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30840>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfyIt-0007N5-4S for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752784AbWKCMhm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWKCMhm
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:37:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52211 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752784AbWKCMhm
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:37:42 -0500
Received: by ug-out-1314.google.com with SMTP id m3so392843ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 04:37:40 -0800 (PST)
Received: by 10.66.216.20 with SMTP id o20mr2582945ugg.1162557460648; Fri, 03
 Nov 2006 04:37:40 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id p32sm787552ugc.2006.11.03.04.37.38; Fri, 03 Nov 2006 04:37:38 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 11:51, Junio C Hamano wrote:

> Seriously, it is perfectly Ok to send "for discussion" feelers

Thank you for all the excellent advice.  Being new here I'm basically trying 
not to make a nuisance of myself :-)

I'll worry less about getting these things right first time; no one here goes 
mad if a patch is wrong and I'm quite enjoying myself really :-)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
