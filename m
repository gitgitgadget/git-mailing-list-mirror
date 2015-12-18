From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Fri, 18 Dec 2015 14:23:12 +0100
Message-ID: <1450444992-25368-1-git-send-email-szeder@ira.uka.de>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 14:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9v1F-0002Eo-0f
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 14:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbbLRNXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 08:23:54 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38592 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752975AbbLRNXx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2015 08:23:53 -0500
Received: from x4db1aa9f.dyn.telefonica.de ([77.177.170.159] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a9v0f-00068U-U4; Fri, 18 Dec 2015 14:23:51 +0100
X-Mailer: git-send-email 2.7.0.rc0.37.g77d69b9
In-Reply-To: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1450445031.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282705>

> On the other hand, I've marked a handful of topics below as "Will
> discard". They were all dormant after waiting for updates for quite
> a long time; interested people may want to help resurrect them.

> * sg/pretty-more-date-mode-format (2015-10-07) 1 commit
>  - pretty: add format specifiers for short and raw date formats
> 
>  Introduce "%as" and "%aR" placeholders for "log --format" to show
>  the author date in the short and raw formats.
> 
>  No comments after waiting for a long time.
>  Will discard.

By adding missing date format specifiers this patch improves
consistency, improves usability of pretty format aliases, benefits at
least one user, and does nothing wrong in its implementation.  I'm not
aware that any updates were necessary to move this forward.

Why discard?
