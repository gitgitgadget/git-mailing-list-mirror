X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 12:59:30 +0100
Message-ID: <8c5c35580612110359h6a8d0727ib669d773560e97f0@mail.gmail.com>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
	 <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
	 <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 11:59:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GHgBME7qgrhq4axmKD0XJBgSi8MMIXRNEllTNz70JRqR/aXge3U+9v9Bl44uuMiTd0HEB0l3Op8dydiVRdyCyyktMIVWtbb8igKLu/bO6xSR8F889Q7WDf0Ave48KK4ztrR/Bx+hLzQWk4w18dF0bxYO9Hx1NwrCLwJPWqf/md8=
In-Reply-To: <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33996>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtjon-0007xk-Jk for gcvg-git@gmane.org; Mon, 11 Dec
 2006 12:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762853AbWLKL7d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 06:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762854AbWLKL7d
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 06:59:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:17763 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762853AbWLKL7c (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 06:59:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1977057nfa for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 03:59:31 -0800 (PST)
Received: by 10.82.167.5 with SMTP id p5mr964871bue.1165838370628; Mon, 11
 Dec 2006 03:59:30 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Mon, 11 Dec 2006 03:59:30 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Lars Hjemli <hjemli@gmail.com> wrote:
> Anyway, I must say I find it rather unlikely for these cases to occur
> (frequently) in real life.

*blush*

Of course this will happen in real life, I just needed to think about
it for a while (it just depends on the _size_ of the thundering hurd,
right?)

Anyway, it's fixed (I think) and pushed out

-- 
