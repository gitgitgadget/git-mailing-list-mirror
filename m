From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Thu, 07 Jun 2012 20:47:14 +0200
Message-ID: <m2sje7ufgt.fsf@igel.home>
References: <m24nqoohss.fsf@gmail.com>
	<CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
	<4FD05B45.2090006@alum.mit.edu>
	<7vd35bjcd6.fsf@alter.siamese.dyndns.org> <m23967vynk.fsf@igel.home>
	<7v3967huss.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Adam <thomas@xteddy.org>,
	John Wiegley <jwiegley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SchkK-0001D4-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879Ab2FGSrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 14:47:45 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57867 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807Ab2FGSrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 14:47:21 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3W7bMp00Hgz4KWFs;
	Thu,  7 Jun 2012 20:47:16 +0200 (CEST)
Received: from igel.home (ppp-88-217-110-237.dynamic.mnet-online.de [88.217.110.237])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3W7bMm2cpLz4KKBp;
	Thu,  7 Jun 2012 20:47:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id D3A94CA2A2; Thu,  7 Jun 2012 20:47:15 +0200 (CEST)
X-Yow: I was in EXCRUCIATING PAIN until I started reading JACK AND JILL
 Magazine!!
In-Reply-To: <7v3967huss.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 07 Jun 2012 10:54:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199437>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Only if the conversion is restarted from scratch.
>
> Yes, that was the use case I was the most worried about.
>
> Often a re-import is one way to validate what you have (and worse
> yet, what you based your recent work on), so unmatching commit
> object names are red flags.

Given the notorious unreliability of cvsps that doesn't look like a very
serious change in comparison.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
