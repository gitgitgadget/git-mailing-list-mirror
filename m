From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 01:55:18 +0200
Message-ID: <AANLkTi=DYaB9+C6j9cH=eGRPsvm1Re-6+jfQmhCzvhKP@mail.gmail.com>
References: <201010081045.46642.david.barr@cordelta.com> <1286495219-14414-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 01:55:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P40JM-0006tU-TV
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 01:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab0JGXzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 19:55:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48435 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab0JGXzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 19:55:39 -0400
Received: by gwj17 with SMTP id 17so162009gwj.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=J9re5FMmmzypiZZg5J0FblJ+0XgDGIsp97HBbkwP+t0=;
        b=ZsjNh2iU+Upp01YnfBnV1NbDNWHvaw3JM2SgNaoPn66Nb8TvsU/ZyWQ/5uc9sAWwiH
         kiXIymbAhmVznkeAJFMPUka24md71lJQk7BnNFeFtDYtinUVGa1e3elPVxL/Fwv/8t01
         WWyL/FzSuE0CV9ZzVrICpDOpeNW5En6mzsal8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aSDSCoBcwlVMzqcH7SYR4Hb9EBmdMu/vMWa25/7fPBoq2fgCn+KvTIfFg00e2RiIeQ
         5CE+iYYLEJLiktBTaLW8ehFeLS3WC4tI4KTEArIjmudjZX36veovO3iL2V9fIBqlrMX1
         +yU/LlUj60uNCCNC7HL/xmdKDIFtrLP9WRsS0=
Received: by 10.150.147.11 with SMTP id u11mr1979921ybd.386.1286495738226;
 Thu, 07 Oct 2010 16:55:38 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 16:55:18 -0700 (PDT)
In-Reply-To: <1286495219-14414-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158464>

Heya,

On Fri, Oct 8, 2010 at 01:46, David Barr <david.barr@cordelta.com> wrote:
> Commit-message-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: David Barr <david.barr@cordelta.com>

I like it, FWIW:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
