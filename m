X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 10:09:00 +0100
Message-ID: <200611030909.02564.andyparkins@gmail.com>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <20061103074857.GA15972@diana.vm.bytemark.co.uk> <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 09:09:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EWmEAmtYN+Ll3xoBepiXVsxHvujmIjtaHZMQ1gcGjMV382A4PeIODqD800Q1ITylZM+vv0NkKV4jtWelK2Dz53UELta742l8ff14vQtebgzV3ODKhbdL9xQ0k8vSn1fREaG39uYppt8+qf/e9s/F7+Z7awgNdGmpsWwITFQqDwM=
User-Agent: KMail/1.9.5
In-Reply-To: <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30802>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfv34-0000B5-M4 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752676AbWKCJJK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 04:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbWKCJJJ
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:09:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:8518 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752676AbWKCJJI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:09:08 -0500
Received: by ug-out-1314.google.com with SMTP id m3so354181ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 01:09:07 -0800 (PST)
Received: by 10.66.216.20 with SMTP id o20mr2308457ugg.1162544946759; Fri, 03
 Nov 2006 01:09:06 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 30sm635410ugf.2006.11.03.01.09.05; Fri, 03 Nov 2006 01:09:06 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 08:51, Junio C Hamano wrote:

> time, switch between them only to compile, test and install but
> never develop on them" workflow is rather specific to top-level
> maintainer's workflow and that is why I said defaulting to
> separate-remote would be an inconvenience to a minority.

This is only a question of the default; why couldn't you (when it exists) use?

  git clone --dont-use-separate-remote URL

To get exactly what you always had if that's what you want?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
