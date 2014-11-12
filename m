From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: git docs typo - patch
Date: Wed, 12 Nov 2014 15:06:39 -0500
Message-ID: <CAEjxke9zbDZJU94gzGJcC8_kQeu2Xw5i_W_A3qbfRsPuKPKgnA@mail.gmail.com>
References: <BAY173-W49EA7A8A775CB44ACF7268A28E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joe DF <joedf@live.ca>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoeGv-0001UT-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 21:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbaKLUMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 15:12:05 -0500
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:49317 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753228AbaKLUME (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2014 15:12:04 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Nov 2014 15:12:04 EST
Received: from mail-qa0-f53.google.com (mail-qa0-f53.google.com [209.85.216.53])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id sACK70gK026951
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 12 Nov 2014 15:07:01 -0500
Received: by mail-qa0-f53.google.com with SMTP id n8so9123037qaq.12
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 12:07:00 -0800 (PST)
X-Received: by 10.224.40.147 with SMTP id k19mr18954652qae.59.1415822820576;
 Wed, 12 Nov 2014 12:07:00 -0800 (PST)
Received: by 10.140.18.114 with HTTP; Wed, 12 Nov 2014 12:06:39 -0800 (PST)
In-Reply-To: <BAY173-W49EA7A8A775CB44ACF7268A28E0@phx.gbl>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-URL-Scanned: Yes
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 2:17 PM, Joe DF <joedf@live.ca> wrote:
> Hello, i have a patch here for the git docs.
> There is a typo.
> See: https://github.com/git/git/pull/103/files
> cheers,
> -
> Joe DF                                    --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This was fixed just over a week ago in commit
03af7cd1580b7a4d9b77c81081d6eabc0338883e.

Also, note that patches are submitted using 'git send-email' to this
mailing list instead of pull requests via GitHub.

Jason
