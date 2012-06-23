From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Sat, 23 Jun 2012 10:51:31 +0200
Message-ID: <m2r4t6qulo.fsf@linux-m68k.org>
References: <m2vcil4n0w.fsf@igel.home>
	<7v4nq5twwg.fsf@alter.siamese.dyndns.org>
	<7v62ainbub.fsf@alter.siamese.dyndns.org>
	<m2y5neqwwj.fsf@linux-m68k.org>
	<7vbokala5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 10:52:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiM4r-0007Jl-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 10:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab2FWIvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 04:51:40 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50353 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab2FWIvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 04:51:39 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WK9Nw0C81z3hhd3;
	Sat, 23 Jun 2012 10:51:24 +0200 (CEST)
Received: from linux.local (ppp-88-217-109-173.dynamic.mnet-online.de [88.217.109.173])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WK9P12YWgz4KK92;
	Sat, 23 Jun 2012 10:51:33 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 2A6431E5329; Sat, 23 Jun 2012 10:51:31 +0200 (CEST)
X-Yow: How's it going in those MODULAR LOVE UNITS??
In-Reply-To: <7vbokala5e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 23 Jun 2012 01:12:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200497>

Junio C Hamano <gitster@pobox.com> writes:

> So with your patch, users of AsciiDoc 8.5.2 will be harmed by the
> same breakage as you get with 8.4.5 and 8.6.6 with or without your
> patch, and without your patch, users of AsciiDoc 8.5.2 gets a lot
> more reasonable output than with your patch?

The behaviour is completely independent from the asciidoc version.  All
three versions produce the same output.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
