From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/5] range-set and line-log bug fixes
Date: Tue, 23 Jul 2013 17:16:23 +0200
Message-ID: <87ehapparc.fsf@linux-k42r.v.cablecom.net>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 17:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1eKF-0001gK-UF
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 17:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757718Ab3GWPQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 11:16:27 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33123 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757514Ab3GWPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 11:16:27 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 23 Jul
 2013 17:16:23 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (217.235.0.128) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 23 Jul 2013 17:16:24 +0200
In-Reply-To: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 23 Jul 2013 10:28:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [217.235.0.128]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231043>

Eric Sunshine <sunshine@sunshineco.com> writes:

> While implementing multiple -L support for git-blame, I encountered
> several bugs in range-set and line-log resulting in crashes. This
> series fixes those bugs.

Acked-by: Thomas Rast <trast@inf.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
