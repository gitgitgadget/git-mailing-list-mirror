From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Makefile: add thread-utils.h to LIB_H
Date: Sun, 26 Feb 2012 19:13:58 +0100
Message-ID: <87fwdxtqc9.fsf@thomas.inf.ethz.ch>
References: <20120224234242.GA3124@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Sun Feb 26 19:14:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1ibq-0001ZG-04
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 19:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab2BZSOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 13:14:04 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:21149 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab2BZSOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 13:14:03 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 26 Feb
 2012 19:13:59 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 26 Feb
 2012 19:13:59 +0100
In-Reply-To: <20120224234242.GA3124@altlinux.org> (Dmitry V. Levin's message
	of "Sat, 25 Feb 2012 03:42:42 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191570>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> Starting with commit v1.7.8-165-g0579f91, grep.h includes
> thread-utils.h, so the latter has to be added to LIB_H.

Oops, my bad.

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
