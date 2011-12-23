From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: I can never finish a push
Date: Fri, 23 Dec 2011 15:39:44 +0100
Message-ID: <m262h773nz.fsf@igel.home>
References: <4EF47DF3.9080809@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 15:39:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re6Hq-0000o0-LC
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 15:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab1LWOju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 09:39:50 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:60842 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab1LWOjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 09:39:49 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id B72CD1C009EE;
	Fri, 23 Dec 2011 15:39:45 +0100 (CET)
X-Auth-Info: 9pni4bfMFi5DVytFVUJdCuKyM44MWk/9yDOFc2zmuIw=
Received: from igel.home (ppp-88-217-99-149.dynamic.mnet-online.de [88.217.99.149])
	by mail.mnet-online.de (Postfix) with ESMTPA id 80E0F1C0004D;
	Fri, 23 Dec 2011 15:39:45 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9C63ACA29C; Fri, 23 Dec 2011 15:39:44 +0100 (CET)
X-Yow: I have accepted Provolone into my life!
In-Reply-To: <4EF47DF3.9080809@bbn.com> (Martin L. Resnick's message of "Fri,
	23 Dec 2011 08:11:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187631>

Martin L Resnick <mresnick@bbn.com> writes:

> So I pull (no merge needed, its fast-forward)

If the merge is fast-forward then you aren't really having anything to
push, are you?  Are you sure you are pushing the right branch?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
