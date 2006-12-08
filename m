X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: How to conver no branches/tags svn repo to git ?
Date: Fri, 8 Dec 2006 16:52:28 +0800
Message-ID: <4b3406f0612080052n6f1bae34q6aa3129d602023ee@mail.gmail.com>
References: <4b3406f0612070531p13611c68lf65a172c5e4e7b@mail.gmail.com>
	 <20061207195919.GA8179@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 08:52:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3zn5xb+DtroctNtDTGpyRT2HozR6sa/9PF2Brxg6IAGJauPgIT1WhPOar6gtQ4NcqsXEMB7zn4mTG7fD2UI1rQhOXKE+OEIoiWNzsKY32kTcxdrN/GJCUJwk4blifm2rnB7xqdmj3jOCh3HbKkaaQZldRU/uDgU/OZA2/l7Onc=
In-Reply-To: <20061207195919.GA8179@localdomain>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33672>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsbT8-0006wf-Mv for gcvg-git@gmane.org; Fri, 08 Dec
 2006 09:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425209AbWLHIwb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 03:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425210AbWLHIwb
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 03:52:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:13541 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425209AbWLHIwa (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 03:52:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1084168nfa for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 00:52:29 -0800 (PST)
Received: by 10.78.17.4 with SMTP id 4mr1695682huq.1165567948710; Fri, 08 Dec
 2006 00:52:28 -0800 (PST)
Received: by 10.78.165.2 with HTTP; Fri, 8 Dec 2006 00:52:28 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Thanks,
---
Dongsheng Song

2006/12/8, Eric Wong <normalperson@yhbt.net>:
> Dongsheng Song <dongsheng.song@gmail.com> wrote:
> > e.g.
> > http://svn.berlios.de/viewcvs/open-iscsi/
> > http://svn.berlios.de/svnroot/repos/open-iscsi
>
> git svn init http://svn.berlios.de/svnroot/repos/open-iscsi
> git svn fetch
>
> --
> Eric Wong
