From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git docs typo - patch
Date: Wed, 12 Nov 2014 15:06:05 -0500
Message-ID: <CAPig+cRpVp9FKJpTUZx=jB+Em8XLyjRid7m7k+EvR1t2T=iJ4w@mail.gmail.com>
References: <BAY173-W49EA7A8A775CB44ACF7268A28E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joe DF <joedf@live.ca>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:06:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoeBA-0006Ir-5D
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 21:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbaKLUGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 15:06:07 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:59801 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbaKLUGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 15:06:06 -0500
Received: by mail-yk0-f177.google.com with SMTP id 9so416606ykp.8
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 12:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=37e2pQnwTi1XMqP2hXoWPTJy6TpFyBfZv4ETQX/x4n4=;
        b=X4m/kBKtPYGnLnw0jzLGmw02l50HBd3hk86RhB7OgTkOXRBZHlO9uR2+sirZ0Bdxax
         d0IOiFvki33dOfKlpYPwaZZ0XZJQ9Is3i0PHZ0d38vZLfxFuPyB9v8FczYnLmhl4yHDN
         /NS6R7FqiVK1O2IboMv8oogzy8tLy0hOYnyQbbRi+2CUrBDjRBZPksOYWlMqSx8sNoEy
         cYJgvybu9r9YdnXCaTwrlupSm98kIiTQx0qFoJtxIYhC0+4Zw8s3HcCWj6ijYCelEP81
         YXvVDmaUIgbqnmFx4ZyZZdJ/VVNFwxGh4hXSoHHQOv42C8SGVYK/kJxhEsHHBo2XXJeX
         BYRw==
X-Received: by 10.170.45.79 with SMTP id 76mr51002357ykn.74.1415822765721;
 Wed, 12 Nov 2014 12:06:05 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Wed, 12 Nov 2014 12:06:05 -0800 (PST)
In-Reply-To: <BAY173-W49EA7A8A775CB44ACF7268A28E0@phx.gbl>
X-Google-Sender-Auth: IPeV9xI2fBKIygWnFjuDxIxPjfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 2:17 PM, Joe DF <joedf@live.ca> wrote:
> Hello, i have a patch here for the git docs.
> There is a typo.
> See: https://github.com/git/git/pull/103/files
> cheers,

Thanks. This is fixed already [1] in the git "master" branch.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/259070
