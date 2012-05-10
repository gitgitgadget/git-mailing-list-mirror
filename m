From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 18:47:38 +0200
Message-ID: <CAGK7Mr7WQFmf1S5ed+1Cu9gRQ-ZgO-t+dj7a8PKRM=U2ZVERyQ@mail.gmail.com>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 18:48:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWXJ-0002Cf-UF
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab2EJQsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:48:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32905 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab2EJQsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:48:10 -0400
Received: by yhmm54 with SMTP id m54so1656803yhm.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=Qh7FpzuMX2nch1QsR0k+QEqgbrDoFGN6UOepZIO/2EA=;
        b=DJn5n8hVUvqCCkfxGQ+Wi/zsMXvFGVNeErxaMY8FEybTb6ByPcSpJOkja9Ue0J2yEs
         rLWbgTGHcgi/g91j65t1uL/1KqTUzxstB8dxSAqPVn0ODriz2x6ntTrH/I0fCGaHAVjh
         P0TxfBLWHccp7A1IJTpT67s+CcvSE5nHP18Q55sCZLrXae/6vj9bmUePZVFKTXmEVjrO
         Nqeo2Grc5sAsk5NF73cP/0XlPtxmcu+NM51BHJAktBpWL0jaLHShP+OaIBNykBp+U5/1
         hnTVm95nJoIxTqvmBM/XrXTpAw/pMkE64kZZk5hZAfBs2bM2WiUzlNam5d6q/lyekAHE
         OTRw==
Received: by 10.50.214.66 with SMTP id ny2mr274712igc.0.1336668488931; Thu, 10
 May 2012 09:48:08 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 09:47:38 -0700 (PDT)
In-Reply-To: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197598>

I see I messed up the commit message which is too long. You can change
it to something like "Clean documentation (git-var/git-commit-tree)"
if you decide to import the patch.

Philippe
