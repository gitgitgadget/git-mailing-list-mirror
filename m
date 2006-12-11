X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: Re: stgit: No patches to pop
Date: Mon, 11 Dec 2006 17:05:20 +0000
Message-ID: <7ac1e90c0612110905x3f1632b9v17bb14e810715cbf@mail.gmail.com>
References: <7ac1e90c0612110632x56a2917cu4db33e47923f34c2@mail.gmail.com>
	 <tnxpsaqwgxl.fsf@arm.com> <elk0c3$ovu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 17:05:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HlVhGds9P2RXogTw13BkneV+tpmPH1gvCvn3+3lT0EPVXWYBM5FDXcN4pxewB0hc8ikJtefuWQLKIL01zI+tkmb8Ygu1/ZqJIWleYIpsZKjMXuBgRI08mWqSmbx1c9ZYnG4E7kA26k8JUu5Obz0ClVfiMmEzvrfaaWDHuy/ziMI=
In-Reply-To: <elk0c3$ovu$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34016>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtoaj-0002Ed-Pg for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762937AbWLKRFX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762943AbWLKRFX
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:05:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:62086 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762937AbWLKRFW (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 12:05:22 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2049283nfa for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 09:05:21 -0800 (PST)
Received: by 10.82.167.5 with SMTP id p5mr1113862bue.1165856720578; Mon, 11
 Dec 2006 09:05:20 -0800 (PST)
Received: by 10.82.186.15 with HTTP; Mon, 11 Dec 2006 09:05:20 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
> That is kind of strange. Pop should work like pop does, for example
> the one in Perl or Python, removing n elements from the stack of applied
> patches. Not work as "float <patch>"...
> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git

As a new user my first expectation was as Catalin has revised. If it's
going to stay as in 0.11 at least it would be nice to have it
described in the wiki.

Thanks,
