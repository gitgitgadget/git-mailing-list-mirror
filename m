From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] t5403-post-checkout-hook.sh: make test operands posix
Date: Tue, 9 Oct 2007 15:05:26 +0200
Message-ID: <8c5c35580710090605w12442ff9hc86e547053cda242@mail.gmail.com>
References: <20071009125130.1343.qmail@bcafc83cd51c05.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gerrit Pape" <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEmH-0006Xf-VY
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbXJINF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbXJINF2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:05:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:13740 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbXJINF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:05:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2025304wah
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xCg5RgHRglL+Tt5uDVqCZe+lqvu+2hC7r0RdbsHlPMU=;
        b=KsoCYoJfiJpj5Ury6hNnxbTuxBd/M3nnhwoTea++42C3iNzMx9b8LQWTinD6/H5D97gmrQO9D1/bjDExWEFBlxjao0qMVAlPyNENBin8qbcKQ7lNLBtQ8kP2UEiK1N0wy/4cJAnePkY6U7cJpDSqt57v9CUQ/MQRZzSxMHiaw0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kdnS7vXq3ZBTSGSPomaPSyG5AFS6cTIj5copd2KqCqpLvxGqmD/C1ydK1bQqvTTbGPmoUJVb2SEaYJEoVsVMBpxyuk2lFgbhtEE8oW1wvWo16WSVlR3EJux6wcI6Bo+X+4stG9fR7w8aEGDzjrb4IPJjXXwzzWURRXpLuFjvBcY=
Received: by 10.114.53.1 with SMTP id b1mr4557325waa.1191935126507;
        Tue, 09 Oct 2007 06:05:26 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 9 Oct 2007 06:05:26 -0700 (PDT)
In-Reply-To: <20071009125130.1343.qmail@bcafc83cd51c05.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60404>

On 10/9/07, Gerrit Pape <pape@smarden.org> wrote:
>  t/t5403-post-checkout-hook.sh |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

An identical patch has already been posted:

  http://article.gmane.org/gmane.comp.version-control.git/59952

--
larsh
