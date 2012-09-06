From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Thu, 06 Sep 2012 11:02:30 +0200
Message-ID: <m2y5knjzh5.fsf@igel.home>
References: <7vipbr6c4q.fsf@alter.siamese.dyndns.org>
	<1346910178-13902-1-git-send-email-ktdreyer@ktdreyer.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ken Dreyer <ktdreyer@ktdreyer.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:06:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Y2N-00018J-0f
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 11:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab2IFJGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 05:06:02 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60543 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab2IFJGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 05:06:01 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XCG8s1KcQz4KKDF;
	Thu,  6 Sep 2012 11:05:48 +0200 (CEST)
X-Auth-Info: 8m/N7gLcfysugTGuHd/E3q6WLRXRke0eIOqBrgomhZU=
Received: from igel.home (ppp-93-104-154-231.dynamic.mnet-online.de [93.104.154.231])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XCG541JjfzbblR;
	Thu,  6 Sep 2012 11:02:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 825CFCA2A2; Thu,  6 Sep 2012 11:02:31 +0200 (CEST)
X-Yow: ..  I'm IMAGINING a sensuous GIRAFFE, CAVORTING in the BACK ROOM
 of a KOSHER DELI --
In-Reply-To: <1346910178-13902-1-git-send-email-ktdreyer@ktdreyer.com> (Ken
	Dreyer's message of "Wed, 5 Sep 2012 23:42:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204871>

Ken Dreyer <ktdreyer@ktdreyer.com> writes:

> +		# See ref.c for these rules.
> +		# Tag cannot contain bad chars. See bad_ref_char in ref.c.

s/ref.c/refs.c/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
