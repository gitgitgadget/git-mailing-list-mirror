From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 10:56:08 +0200
Message-ID: <CAB9Jk9D8ZptEcBhCdzxUtWhKD__mYZ-J_TZQr70dOvED2uB0SQ@mail.gmail.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
	<CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com>
	<CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com>
	<CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com>
	<50656388.3050400@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Frans Klaver <fransklaver@gmail.com>, git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 10:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THWMv-00012Y-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 10:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab2I1I4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 04:56:10 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53911 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2I1I4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 04:56:09 -0400
Received: by vbbff1 with SMTP id ff1so2889688vbb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZgKScyzeTRKS6+JdPkVMAxLs4z82A+iUgMhKtE4E8w8=;
        b=otTr+vztAl4Z41GdwWjax/U+0rgVWpUSqxd0Xj39DUzAnvOqalXM51VNmLRO2j9OuA
         rhvoeHQynxvfeYeOKrCZMkyaKIEB0pD33TwuXkJ4H8CZbt4YIjv0r+jCL827rDlAFQqv
         7VhnSoONBhtPOgUgMuNyWScdfV1G/nFoCAKB8gPBvNc/eq/mA+Xpm7tQckNMm5LxQ0MF
         1OKQ9VP9YwQo07HDrD5O3xm0x+V5uqEASkcFqPij0KpqhnRD2amq0XGHLVeeJlDJWLhS
         0xV+k9BBzcWax3peAlTbL7VOgEtf3KZZcwMiI9z+pcGw6KlrZbMVMpgwgSvX7PeH9jCD
         i0PQ==
Received: by 10.58.227.106 with SMTP id rz10mr3833927vec.19.1348822568289;
 Fri, 28 Sep 2012 01:56:08 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Fri, 28 Sep 2012 01:56:08 -0700 (PDT)
In-Reply-To: <50656388.3050400@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206547>

Then the misleading message is due to the Italian localization of the git gui.

-Angelo
