From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] perf: update documentation of GIT_PERF_REPEAT_COUNT
Date: Sun, 10 Mar 2013 21:32:34 +0100
Message-ID: <87boaratct.fsf@pctrast.inf.ethz.ch>
References: <1362842965-3446-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 21:33:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEmvZ-00042g-S8
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 21:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab3CJUcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 16:32:39 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42493 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab3CJUcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 16:32:39 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 10 Mar
 2013 21:32:34 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 10 Mar
 2013 21:32:36 +0100
In-Reply-To: <1362842965-3446-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Sat, 9 Mar 2013 16:29:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217818>

Antoine Pelisse <apelisse@gmail.com> writes:

> Currently the documentation of GIT_PERF_REPEAT_COUNT says the default is
> five while "perf-lib.sh" uses a value of three as a default.
>
> Update the documentation so that it is consistent with the code.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>

Acked-by: Thomas Rast <trast@inf.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
