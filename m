From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-show-ref.txt: clarify the pattern matching
Date: Mon, 18 Oct 2010 14:07:29 +0200
Message-ID: <201010181407.30770.jnareb@gmail.com>
References: <201010181203.38554.jnareb@gmail.com> <21215c6fd41bd344c4226f410b69680f3901549b.1287401559.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 18 14:07:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7oVI-00072O-Ul
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 14:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab0JRMHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 08:07:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42474 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab0JRMHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 08:07:42 -0400
Received: by fxm4 with SMTP id 4so529768fxm.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jLUwRhz0W1mg8OmIApucJWYM7kNld+qqzviHClyr4Jo=;
        b=A/hmKlGFXhSK0AbLai2+Rybhwem4g5Rn/CF+/Fs+2t5nPqWNKXkCTfuKl+uXVMSLtc
         XiUHpRR0r7GHl7CD5jXsDQKz29rTs4+hdMvQJO7ipQFCZ+0T1OM+npsSnoCztwEz1oXs
         KkVgJFBi5UUwrZuSXVxJNJpQawnBUMfCHBIWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TNmsQJNtCXpleN90WdYmj1LnudJrevzs9zX9vuGFyVq4xDtm89KsUigA40pmjrFALo
         iZ4+0mQtjfnc/10aStAPHEhQ/8gPlaKQBrSiVjKk2Qsk2TB1Fcz0Shw5BjPHLf1SUUoX
         u6EaTqE/bF/lD9jxl5C3ZDbKCI72qU752Zk0I=
Received: by 10.103.172.15 with SMTP id z15mr1955747muo.42.1287403660774;
        Mon, 18 Oct 2010 05:07:40 -0700 (PDT)
Received: from [192.168.1.13] (abwp24.neoplus.adsl.tpnet.pl [83.8.239.24])
        by mx.google.com with ESMTPS id k4sm3134296faa.32.2010.10.18.05.07.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 05:07:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <21215c6fd41bd344c4226f410b69680f3901549b.1287401559.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159254>

Michael J Gruber wrote:

> git-show-ref really does not do what one would expect under the name
> pattern matching, so describe it.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Thanks a lot!  That clarifies it.

-- 
Jakub Narebski
Poland
