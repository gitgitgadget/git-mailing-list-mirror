X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 01:29:41 +0100
Message-ID: <200612110129.41721.jnareb@gmail.com>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com> <eli7e3$srp$1@sea.gmane.org> <8c5c35580612101616g179715ecyd02fcbb023246ecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 00:27:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qXdT01vTEdmJfgqoHRRAm0Gcf6YQt7td9ewgAU2tmFVMS75Pkihw8L2S26rrT98SeWhLgcM6SrDrQD2ChLE23yZ0aTibB/W7JlCv7SBiOXb5R/MZ8LtP1qJIFXp122VZ7XWRbiE4wrZwRj7/APWTZhEEs3WiW4ieY7WYNbIhIsw=
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580612101616g179715ecyd02fcbb023246ecc@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33968>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtZ16-0005V4-Rv for gcvg-git@gmane.org; Mon, 11 Dec
 2006 01:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762581AbWLKA12 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 19:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762548AbWLKA11
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 19:27:27 -0500
Received: from hu-out-0506.google.com ([72.14.214.226]:52808 "EHLO
 hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762577AbWLKA11 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 19:27:27 -0500
Received: by hu-out-0506.google.com with SMTP id 36so761593hui for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 16:27:25 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr2745807ugm.1165796845438; Sun, 10
 Dec 2006 16:27:25 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id u6sm6443673uge.2006.12.10.16.27.25; Sun, 10 Dec
 2006 16:27:25 -0800 (PST)
To: "Lars Hjemli" <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

Lars Hjemli wrote:
> On 12/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
> 
>> Hmmm... git has now 4 web interfaces (5 if counting gittracker, which works
>> but gittracker repository shows empty): gitweb in Perl, git-php in PHP, wit
>> in Python (is it actively developed? where it can be downloaded from?),
>> gitarella in Ruby, now CGit in C...
> 
> Hmm, it must be a popular scm :-D

Miscalculation: it is 5 with yours (6 counting gittracker).

-- 
Jakub Narebski
