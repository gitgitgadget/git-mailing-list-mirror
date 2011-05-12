From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #05; Wed, 11)
Date: Thu, 12 May 2011 13:16:46 -0700 (PDT)
Message-ID: <m362pf7jzr.fsf@localhost.localdomain>
References: <7vhb91f0jc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 22:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKcJc-0002qy-5P
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 22:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523Ab1ELUQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 16:16:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33660 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039Ab1ELUQu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 16:16:50 -0400
Received: by bwz15 with SMTP id 15so1601923bwz.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=Tik6AR4R0/I4Uy9R5xJB7CZ42OifKtRGCVju1tI7Lpc=;
        b=o/pk16werw8N8a7EG3Gakm+TzdtntP6amT2C062tKYSC2QuQvGqXmmRGnr/CdTxDIK
         yc8grnCLpg2x0qf/Jjr2BzbtzXHruA+70TkiSB2Oqq9QgX5VfYpyD72nDt0WGRvhJ7Wr
         Qjg6HhS3tbufaHjcJRvFXY9YK/mM94KngGToY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CRzEU+j+6k4iAK5wJ2Pth3wSmSkjPtN4Fj+GSxE6yxtyIw611TgCMJKsxdpgIDUx7L
         j/50WE+KbN4nCv6Xkk1oZQHSQ45LnpcJTMFEKeSmSshn78GT5wuZTVWoT69Ts9kNd2Kf
         7Kom8c22hh2rZFH69RjhW5sVt4zD+MqAloK04=
Received: by 10.204.181.7 with SMTP id bw7mr634401bkb.16.1305231407233;
        Thu, 12 May 2011 13:16:47 -0700 (PDT)
Received: from localhost.localdomain (abvl88.neoplus.adsl.tpnet.pl [83.8.209.88])
        by mx.google.com with ESMTPS id q24sm931825bks.21.2011.05.12.13.16.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2011 13:16:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4CKGObc012680;
	Thu, 12 May 2011 22:16:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4CKG8VI012671;
	Thu, 12 May 2011 22:16:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vhb91f0jc.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173496>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Graduated to "master"]

> * jn/ctags (2011-04-29) 3 commits
> * jn/gitweb-dependency (2011-05-08) 2 commits

> --------------------------------------------------
> [Stalled]

> * jn/gitweb-js (2011-04-28) 13 commits
> * jn/ctags-more (2011-04-29) 3 commits

What about "[PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into modules"
http://thread.gmane.org/gmane.comp.version-control.git/172659
git://repo.or.cz/git/jnareb-git.git gitweb/split

-- 
Jakub Narebski
Poland
ShadeHawk on #git
