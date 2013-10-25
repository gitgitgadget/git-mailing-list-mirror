From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] rev-parse --parseopt: add the --sticked-long mode
Date: Sat, 26 Oct 2013 00:52:23 +0200
Message-ID: <20131025225222.GL4589@mars-attacks.org>
References: <20131016223306.GN9464@google.com>
 <1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
 <xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 00:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZqFA-00036Z-4y
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 00:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784Ab3JYWw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 18:52:27 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:42060 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab3JYWwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 18:52:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 077C648C3;
	Sat, 26 Oct 2013 00:52:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ttkU9ifOr-62; Sat, 26 Oct 2013 00:52:38 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 87C754238;
	Sat, 26 Oct 2013 00:52:38 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 0BF3143934; Sat, 26 Oct 2013 00:52:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236722>

On Fri, 25 Oct 2013, Junio C Hamano wrote:

> Nicolas Vigier <boklm@mars-attacks.org> writes:
> 
> > Add the --sticked-long option to output the options in their long form
> > if available, and with their arguments sticked.
> 
> Hmph, doesn't verb "stick" conjugate to "(present) stick (past) stuck
> (pp) stuck"?

Ah, yes it seems. I don't know if 'sticked' is also correct or not.

However, 'sticked' is the word that is used in Documentation/gitcli.txt
and Documentation/technical/api-parse-options.txt.
