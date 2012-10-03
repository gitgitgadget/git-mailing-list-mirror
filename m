From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 18:44:55 +0200
Message-ID: <m2fw5va4jc.fsf@igel.home>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<m2fw5vooem.fsf@linux-m68k.org>
	<CAB9Jk9Dqoom-hBQPG5iqe2JyiJtVoFWZ9-5W9ktUsa9F9mbXRQ@mail.gmail.com>
	<m2r4pf1xh6.fsf@igel.home>
	<CAB9Jk9Bqq=fs4v-oAj_TiaSw5WOiQQFsm_WEZP_ECyPW1L_DHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:45:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJS4V-0005On-V4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 18:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab2JCQpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 12:45:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47833 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab2JCQpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 12:45:03 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XX3490CMFz3hhfZ;
	Wed,  3 Oct 2012 18:44:57 +0200 (CEST)
X-Auth-Info: De1GHzu5N5HcO9yElV/9Ynn98phWpzhLmL5OF5YrRmU=
Received: from igel.home (ppp-93-104-158-56.dynamic.mnet-online.de [93.104.158.56])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XX3486rYjzbbfw;
	Wed,  3 Oct 2012 18:44:56 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 46009CA2B8; Wed,  3 Oct 2012 18:44:56 +0200 (CEST)
X-Yow: ...It's REAL ROUND..  And it's got a POINTY PART right in the MIDDLE!!
 The shape is SMOOTH..  ..And COLD.. It feels very COMFORTABLE on my
 CHEEK..  I'm getting EMOTIONAL..
In-Reply-To: <CAB9Jk9Bqq=fs4v-oAj_TiaSw5WOiQQFsm_WEZP_ECyPW1L_DHg@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 16:37:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206912>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> it does not state plainly that no commit object is created.

But the commit object _is_ created, it just doesn't have a unique name.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
