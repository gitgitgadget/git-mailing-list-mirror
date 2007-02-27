From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 21:41:36 +0100
Message-ID: <87vehn2v0f.fsf@wine.dyndns.org>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
	<86odnfr625.fsf@blue.stonehenge.com>
	<7vzm6zcpv0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: merlyn@stonehenge.com (Randal L. Schwartz), git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM99I-0008Mh-0I
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933101AbXB0Ulk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbXB0Ulk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:41:40 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53982 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933101AbXB0Ulj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:41:39 -0500
Received: from adsl-84-226-50-1.adslplus.ch ([84.226.50.1] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HM98k-0007b5-Jc; Tue, 27 Feb 2007 14:41:39 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7AAEC4F691; Tue, 27 Feb 2007 21:41:36 +0100 (CET)
In-Reply-To: <7vzm6zcpv0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Tue\, 27 Feb 2007 12\:22\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40792>

Junio C Hamano <junkio@cox.net> writes:

> 20276889 (daemon socksetup() does not set FD_CLOEXEC)
> 	a87e8be2 Jul 13 2005
>
> Alex Julliard.

... by noticing breakage when upgrading to 1.5.0.

-- 
Alexandre Julliard
julliard@winehq.org
