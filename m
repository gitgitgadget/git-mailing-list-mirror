From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 21:03:04 +0200
Message-ID: <m2iparnztj.fsf@igel.home>
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
	<m2fw5va4jc.fsf@igel.home>
	<CAB9Jk9Aa4d4H5q1euCJ4hdc_K9iBrfiJFnyAYQ+BRNX3D023gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIL-0001DP-9f
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab2JCTDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 15:03:16 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49510 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab2JCTDM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 15:03:12 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XX67Y1Wjtz3hhjQ;
	Wed,  3 Oct 2012 21:03:05 +0200 (CEST)
X-Auth-Info: yd/BAFhb+XhYxQ1YRaOP6BhNWHUenDBbYKi7E3L5HjM=
Received: from igel.home (ppp-93-104-158-56.dynamic.mnet-online.de [93.104.158.56])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XX67Y14ZVzbbg3;
	Wed,  3 Oct 2012 21:03:05 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 9E6A8CA2B8; Wed,  3 Oct 2012 21:03:04 +0200 (CEST)
X-Yow: Sometime in 1993 NANCY SINATRA will lead a BLOODLESS COUP on GUAM!!
In-Reply-To: <CAB9Jk9Aa4d4H5q1euCJ4hdc_K9iBrfiJFnyAYQ+BRNX3D023gg@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 19:37:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206925>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> that after the command there are no new objects.

That is an uninteresting implementation detail.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
