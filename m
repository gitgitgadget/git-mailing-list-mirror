From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] Add a function skip_prefix_if_present()
Date: Thu, 6 Feb 2014 19:19:06 +0700
Message-ID: <CACsJy8Dd8jD_mCGWsNfm0HJ=F5Ax17dqjd+jJ-RAMotjOU6tzw@mail.gmail.com>
References: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu> <52F1E04D.3090208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kent R. Spillner" <kspillner@acm.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 06 13:19:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBNvi-0000jh-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 13:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439AbaBFMTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 07:19:38 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:49730 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbaBFMTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 07:19:37 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so2549592qac.22
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 04:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wmi2XqkkQBrL+0TLelxnceoZZhRPMP6slRd9DhAktRo=;
        b=rgawuMH0Fqq9/RKyeiTDtkrtziUWE6qwy75hZ51iQaubAOl68NgiTRPbFyqrI21/+X
         eL1ZPuyq5QY87vNhN/70O1r1LMZHbFF7HUUgwTZBlKNELzPf3SQD4Ege6wJrvE6sOdCp
         sgOCqBM0blIaahRNTekGHQWmvpBGSghFXGcQfq9R3l9XXliV4+9h18kTyge02rfymFTK
         KquoeaynA3DOEgdZhOdOo4JH5P6vTaxb4b+FzeCQvbMOA2XoTO6ZzSkTPrBEjvLmCgS1
         Uu5l+v1KZTLidAxpSL4DWFw7yOUmA6T88f2CbcHSauVRjlb+0eta4EMa/95ShwasxQg4
         AtqA==
X-Received: by 10.140.47.212 with SMTP id m78mr11086944qga.21.1391689176641;
 Thu, 06 Feb 2014 04:19:36 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Feb 2014 04:19:06 -0800 (PST)
In-Reply-To: <52F1E04D.3090208@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241688>

On Wed, Feb 5, 2014 at 1:55 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> * Duy seemed to offer to rewrite his patch series, but I don't think
>   that it has happened yet.

It's really low in my todo list. So if you want to pick it up, please do.
-- 
Duy
