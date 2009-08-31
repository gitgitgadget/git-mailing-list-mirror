From: Tim Visher <tim.visher@gmail.com>
Subject: `Git Status`-like output for two local branches
Date: Mon, 31 Aug 2009 16:20:47 -0400
Message-ID: <c115fd3c0908311320q46d585d2v457ccd0f411a6404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiDNN-0002Gv-6H
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbZHaUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbZHaUVG
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 16:21:06 -0400
Received: from mail-yw0-f188.google.com ([209.85.211.188]:39495 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbZHaUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 16:21:05 -0400
Received: by ywh26 with SMTP id 26so6541491ywh.5
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 13:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=9dS55B5PmdecbGRcPbHnyumNR3mpuOgs2QZEp/0nLsU=;
        b=UcA9CI5TaPzqJdSRIXBpe3fOjVy6lJDGNW3QfjpYA8ckJdCfcnhfcAreLlNZfgLtE7
         pMdDL+/HLP5rmy49Aw41rJqrsCtsE64++gQrtLq1MvgKzeiex0MTFqRmBfrgqzsNg6HZ
         cntd32iZf2mCcUnxakYgpgl1ecbKQieE2V0N4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=eq6wkJfRJ9K+0KNrQB/IV3ruYOw8I+sh6HMBYHdbDVSojKTwrr0WeQ3FWP3pEnwL/4
         uIIUiWpJGQFDGBfjBBDDtdqDsStDNio/XJwadHWygWQ1c/zofgO+lBcxJh9rzwm8ntml
         2ftGGSW91BPAH5Iqkp4Tuxs9ZWLc3cD1glaPA=
Received: by 10.101.96.5 with SMTP id y5mr6344864anl.89.1251750067198; Mon, 31 
	Aug 2009 13:21:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127498>

Hello Everyone,

I'm interested in being able to get a message such as 'dev and master
have diverged, having 1 and 2 commits different respectively' or 'dev
is behind master by 3 commits and can be fast-forwarded', etc.  I'm
sure this is simple, but I can't figure out how to do it in the docs.
Sorry for the noobness of the question.

Thanks!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
