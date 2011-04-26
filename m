From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] --dirstat fixes, part 2
Date: Mon, 25 Apr 2011 17:15:41 -0700
Message-ID: <BANLkTi=sP3zu45R_s_3w-oMuMh1fGGv=vQ@mail.gmail.com>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com> <1303776102-9085-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 02:16:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEVwp-0003Zw-Qa
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 02:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab1DZAQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 20:16:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51141 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932233Ab1DZAQF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2011 20:16:05 -0400
Received: from mail-vw0-f46.google.com (mail-vw0-f46.google.com [209.85.212.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3Q0G3qV007494
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 25 Apr 2011 17:16:04 -0700
Received: by vws1 with SMTP id 1so103322vws.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 17:16:01 -0700 (PDT)
Received: by 10.52.100.10 with SMTP id eu10mr133056vdb.208.1303776961084; Mon,
 25 Apr 2011 17:16:01 -0700 (PDT)
Received: by 10.52.114.202 with HTTP; Mon, 25 Apr 2011 17:15:41 -0700 (PDT)
In-Reply-To: <1303776102-9085-1-git-send-email-johan@herland.net>
X-Spam-Status: No, hits=-103.469 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172061>

On Mon, Apr 25, 2011 at 5:01 PM, Johan Herland <johan@herland.net> wrote:
>
> I finally found the time to re-roll the remaining dirstat fixes,
> incorporating feedback from Linus and Junio in the surrounding thread.

After a _very_ superficial walk-through of the patches, I have no real
issues. Looks ok by me,

                 Linus
