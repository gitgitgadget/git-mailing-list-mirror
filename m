From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Fix signal handler
Date: Wed, 3 Feb 2010 07:52:52 -0800
Message-ID: <20100203155252.GA14799@spearce.org>
References: <4B684F5F.7020409@web.de> <20100203102915.GA25486@coredump.intra.peff.net> <4B696447.10803@web.de> <201002031412.53195.trast@student.ethz.ch> <4B699A45.7000905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 16:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NchXT-0001va-06
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 16:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367Ab0BCPxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 10:53:04 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57894 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757363Ab0BCPw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 10:52:59 -0500
Received: by vws20 with SMTP id 20so486772vws.19
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 07:52:58 -0800 (PST)
Received: by 10.220.44.197 with SMTP id b5mr5216559vcf.111.1265212375726;
        Wed, 03 Feb 2010 07:52:55 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 39sm81683588vws.14.2010.02.03.07.52.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 07:52:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B699A45.7000905@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138841>

Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > So why don't you post patches (either fixes or testcases exhibiting
> > the issue) instead of more mails containing the same points?
> >   
> 
> I try to get a feeling about acceptance for update suggestions before
> they can be expressed in the target programming language.

We've been burned too many times by people who drive-by and demand
we fix X, without showing proof that X is a problem, or offering
a patch to resolve whatever X they claim is an issue.  Each such
time burns existing well-known contributor time.

We've also been burned too many times by well-known contributors
posting "Hey, we should do Y" and then never actually writing the
code themselves.  I know, I've done it.

Pie-in-the-sky discussions serve no purpose, and just waste
everyone's time.


If its worthwhile, write the damn code, and share it.  If its not
worth your time to write the code in order to propose the idea,
its not worth our time to listen.

I've never kill-filed _ANYONE_ on this mailing list before.  You are
>.< this close to making me go figure out how to setup a kill file
on my domain just so I can stop receving all emails from you.


-- 
Shawn.
