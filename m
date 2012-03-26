From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] documentation: fix alphabetic ordered list for git-rebase
 man page
Date: Mon, 26 Mar 2012 13:57:43 +0200
Message-ID: <4F7059B7.8080406@op5.se>
References: <4F6C5F1B.6010603@seap.minhap.es> <7vd383t8vp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 13:58:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC8Yp-0002Wx-4z
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 13:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441Ab2CZL5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 07:57:42 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37211 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932429Ab2CZL5l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 07:57:41 -0400
Received: by lahj13 with SMTP id j13so3824678lah.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 04:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=iTx8KIjvzoKinq4hf88eOfXWtReHj39Fmn0zkJO9Mes=;
        b=YY7QtobGQBubiMx+zjhE0GniJ/+Q1HZc6d4TlKdiCYtB0Q1ypH03Z+yLEj35Ek/HbT
         F9m78euVSM5f4YO5RPZeRpswC1e7Jt38wU0pomDuNZI0GeRT3ewsJ9PPEsCqfuKnMMqL
         8AyfstrkIOHQjUXRT9sjWKohpxXdsifEiuNhTHqwTXD685oCjTO8DVqUldcmqP6XURGf
         kKDM5lefNS3lgkET4XTsl8p9ZW35ztKP7OUYjkuWiMh9HO7snLvLTepweel31OjfRtRN
         dtcOlsbAhNGD3T+S/ap2ubDo4anGHiwGoyW3Fp0qH1q/9w8dUdiVzmNVnYptdkM5crTf
         IO5g==
Received: by 10.152.162.72 with SMTP id xy8mr16177049lab.32.1332763059893;
        Mon, 26 Mar 2012 04:57:39 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id ml19sm16982058lab.1.2012.03.26.04.57.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 04:57:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <7vd383t8vp.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkQDQF1CAdKhbhXiXQ2VMZza4b84tUQvO6S+lJeSWMoRcTVnf+p9LNfNDPS4YPu4Pt1lZxL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193906>

On 03/23/2012 08:28 PM, Junio C Hamano wrote:
> Thanks; sign-off?

Having just checked up on this myself for a project I maintain and
was sent a patch without signoff (we shamelessly stole git.git's
meaning of signoffs), I have it on a copyright lawyer's word that
you can safely forge the sign-off for anything that provides a
bugfix without adding a new way of doing things, since only changes
that carry a certain amount of originality can be copyright protected.

Fixing an alphabetic ordering is too trivial to grant the author of
the fix any right to the resulting work, as are typo-, grammar and
one-line syntactical fixes (adding missing braces, etc), and therefore
they do not need to sign off on the fact that they have a right to
give others the right to use that work, since they in fact do not have
the right to restrict others from using it in the first place.

Just thought I'd throw that out there in case you, like I did, run into
useful patches you dare not use because the original author gets hard
to contact all of a sudden.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
