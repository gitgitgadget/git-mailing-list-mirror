From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [PATCH 0/2] Setting git tree of a patch (improved version)
Date: Wed, 26 May 2010 17:34:22 +0200
Message-ID: <AANLkTiltxW_teNgNxZnJLqbiO3Du6al3K48wlcDooVZd@mail.gmail.com>
References: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
	 <20100524184908.30884.65042.stgit@sambuntu>
	 <AANLkTimgpjn5KZpujtmXfd7UtEfJTg-3UcmIjvFor0bX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 17:34:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHIco-0001HR-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 17:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab0EZPeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 11:34:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45368 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab0EZPeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 11:34:23 -0400
Received: by fxm5 with SMTP id 5so4553675fxm.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TG2Kp4QyA6n3/wjiz617vbpxcTziW8XVDzu0inyuEo0=;
        b=aMqBn4M2OwJzaTnhIW7f1h2JgRzCYA7Q+V77T+S7UoE7xfMi5liixfM1JkXenc/uYj
         R5L11EX9ck6LNyIHFVbgmO2xiZgUse0V5Fn/8+AkdPimWUPIRuWGLsDB9yRFieKwqdU/
         lE0HoP7eZeZQQe5Ceu0aumlCyPgBcUmuCfXY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PJ8OVxWDMIZnH7h2MW2it10lv63hXTLMKNtBMF8iB6MXigYJWikY4aa1SrnTnZuSEe
         8HZmKwV5wVVhB0tbmu1Q3n2HLJlwCcKcTR+arx1Ixv/FAtYG6hnRKR5priymtvVNuNqk
         lZ5UxmkyzX3Jr9XWVfPjRqD8sjfRN5QU24/zs=
Received: by 10.204.47.74 with SMTP id m10mr1067765bkf.19.1274888062090; Wed, 
	26 May 2010 08:34:22 -0700 (PDT)
Received: by 10.204.76.68 with HTTP; Wed, 26 May 2010 08:34:22 -0700 (PDT)
In-Reply-To: <AANLkTimgpjn5KZpujtmXfd7UtEfJTg-3UcmIjvFor0bX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147806>

On Tue, May 25, 2010 at 2:26 PM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:
> The patches look fine to me.
>
> Do you want me to merge them directly or I grab them via some git tree
> (or Karl's).

You can grab them from git://github.com/gustavh/stgit.git in the
'set-tree' branch.

Somewhat unrelated, I have a string of patches in my 'proposed' branch
(same repository) which contain various fixes to the Emacs mode.
Would you like me to post them here as one patch series or would you
prefer to handle it some other way?

Karl has a bit too high latency these days, so it's inconvenient to go
via his branch(es).

- Gustav
