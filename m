X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alexander Litvinov" <litvinov2004@gmail.com>
Subject: Re: Git can't merge two identical move file operation
Date: Thu, 16 Nov 2006 18:25:18 +0600
Message-ID: <6e1787fe0611160425l6ed76a5cncbb0236cbf0b5161@mail.gmail.com>
References: <6e1787fe0611160226r2d51d980t6899f1a1018b5fe5@mail.gmail.com>
	 <7v1wo3bp99.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 12:25:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=erYoerb/VNiDgSd4rU389xulfrwjdGbM7xGzIBP6k2oz/lbYia91oWLq/M0avMREU7VakeVRS7JVj8tom+UAiSsHRUtGzXddeJ7wcNXSJlV4esRK1qdcilOVR9euuzk0T42Iz9trVDMMvMuYPZQgm8ay//Z6Rv+12Wc76e0U+Fk=
In-Reply-To: <7v1wo3bp99.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31578>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkgJ2-0002S1-EQ for gcvg-git@gmane.org; Thu, 16 Nov
 2006 13:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161912AbWKPMZV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 07:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWKPMZU
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 07:25:20 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:10878 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1161912AbWKPMZT
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 07:25:19 -0500
Received: by nz-out-0102.google.com with SMTP id l1so266526nzf for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 04:25:19 -0800 (PST)
Received: by 10.35.18.4 with SMTP id v4mr645419pyi.1163679918793; Thu, 16 Nov
 2006 04:25:18 -0800 (PST)
Received: by 10.35.83.2 with HTTP; Thu, 16 Nov 2006 04:25:18 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

