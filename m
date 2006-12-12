X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Using git as a general backup mechanism (was Re: Using GIT to store /etc)
Date: Wed, 13 Dec 2006 12:23:07 +1300
Message-ID: <46a038f90612121523p5278fd43mffb90d9d92cd2fde@mail.gmail.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
	 <Pine.LNX.4.64.0612111837210.20138@iabervon.org>
	 <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
	 <200612121553.37499.andyparkins@gmail.com>
	 <457F31E6.8090701@midwinter.com>
	 <46a038f90612121515l77c77376xd98e148498e889c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 23:23:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RKND2XvF2LhW1OJX86nfyiYTisAkZwPNo1V9hpVli0e6TtByx2cFbDFtFl5rrmi5zvIH8dWxYlbalx3VTFi6DzBGptRLWoQFqlvdoNwZkvJXRhKzKO9rQ/1rCvWvDbOb3wM20FpO4PNlq1zEV+jPBAVLwwHXlkji80ZosvKdz30=
In-Reply-To: <46a038f90612121515l77c77376xd98e148498e889c4@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34166>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGxu-0004gk-4H for gcvg-git@gmane.org; Wed, 13 Dec
 2006 00:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932500AbWLLXXL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 18:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWLLXXL
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 18:23:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:45448 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932500AbWLLXXJ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 18:23:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so365377nfa for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 15:23:07 -0800 (PST)
Received: by 10.49.41.12 with SMTP id t12mr1999457nfj.1165965787716; Tue, 12
 Dec 2006 15:23:07 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Tue, 12 Dec 2006 15:23:07 -0800 (PST)
To: "Steven Grimm" <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

On 12/13/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> I've been thinking myself of writing a pdumpfs lookalike that uses git
> internally. Sounds you you've got one already ;-)

Actually - what I was considering was mixing the "daily commit" with
GITFS ;-) http://www.sfgoth.com/~mitch/linux/gitfs/

are your scripts published anywhere?

cheers,


