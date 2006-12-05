X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-explain
Date: Wed, 6 Dec 2006 12:00:14 +1300
Message-ID: <46a038f90612051500w44438f70y3c7d1c99998d16bb@mail.gmail.com>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	 <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
	 <7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
	 <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
	 <el3ibq$9kn$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 23:01:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YpsnfRc2oBx48eSQ2VbSd4F+boOsRy6dzmoXITgBpz4edJK9TDmNDkxCUYS6PbZa2KfmjWKpFngXzX3E7m5ZJVx0nZoK7Uj6nCH0+ALJpgCCY9ffkGxnWNNwCwZUuFoaQTa4pSAUFqT8XuT7KQPRgRw0JKIymOn8aUXfpLydukw=
In-Reply-To: <el3ibq$9kn$2@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33386>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrjHg-00032w-5j for gcvg-git@gmane.org; Wed, 06 Dec
 2006 00:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967195AbWLEXAT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 18:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967412AbWLEXAT
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 18:00:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:18755 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S967391AbWLEXAQ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 18:00:16 -0500
Received: by nf-out-0910.google.com with SMTP id c2so333478nfe for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 15:00:15 -0800 (PST)
Received: by 10.49.7.9 with SMTP id k9mr1372279nfi.1165359614867; Tue, 05 Dec
 2006 15:00:14 -0800 (PST)
Received: by 10.49.51.10 with HTTP; Tue, 5 Dec 2006 15:00:14 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/5/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
>
> > [PATCH] git-explain
> >
> > This patch adds "git-explain" script that notices various clues
> > other commands can leave the working tree and repository in and
> > intended to guide the end user out of the confused mess.
>
> I like it, although I think that it explains a bit too little

I like what it does too... but why not as part of git-status?

cheers,


