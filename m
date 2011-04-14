From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Thu, 14 Apr 2011 11:46:07 -0700 (PDT)
Message-ID: <m362qg3c5j.fsf@localhost.localdomain>
References: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:46:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QARYq-0005c1-UI
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 20:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab1DNSqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 14:46:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48046 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab1DNSqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 14:46:11 -0400
Received: by bwz15 with SMTP id 15so1615483bwz.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=dBJDO8AgLjUjqnKTCB7eVYQLZUSXVSp/64v/3ANQ3Yg=;
        b=uNjHQLj5iFLuGfdW5CMX/m3+Z15aV63m4uAbfjts3kIPGOTKyUhZvicLGbl9miE/rj
         l0HKvbhtjVia/EAxiXlpaZmsLw5drkMAFFTwxqjlvQf/ecTmd2T9LtOmDXGYe7HpvgwO
         m8kt8ByZzU+0KunmEeQRkB5I1p27+bFBOcXxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YKpvxsKOKVhF0eUu64V4Kv7Lhoq1TCuH9Q/z440mArEIX2h8V1upqr5TKvKFphSwFm
         iDT+jquaosVC4IktVTdPHW457Mbe81vfPd5OFJJlPVnSXXHUEJh51NSm0fMxF2dlUSB5
         eOfHCF8HVlLplBespjMKFeq9TvFILN3kQxnuo=
Received: by 10.204.154.194 with SMTP id p2mr889079bkw.58.1302806769994;
        Thu, 14 Apr 2011 11:46:09 -0700 (PDT)
Received: from localhost.localdomain (abwc79.neoplus.adsl.tpnet.pl [83.8.226.79])
        by mx.google.com with ESMTPS id p11sm700635fak.3.2011.04.14.11.46.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 11:46:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3EIjToE007492;
	Thu, 14 Apr 2011 20:45:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3EIjDcQ007488;
	Thu, 14 Apr 2011 20:45:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171533>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Stalled]

> * jh/gitweb-localtime (2011-03-23) 1 commit
>  - gitweb: javascript ability to adjust time based on timezone
> 
> Re-roll posted on the list, but I haven't picked it up.

Should I post v2 of re-roll, or wait for after 1.7.5?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
