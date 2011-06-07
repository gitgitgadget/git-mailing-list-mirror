From: Christian Couder <christian.couder@gmail.com>
Subject: Re: new tool for git: git-blameall
Date: Tue, 7 Jun 2011 13:38:25 +0200
Message-ID: <BANLkTinEJFhGpSPYg=4ciDe4=0E5k6zfoA@mail.gmail.com>
References: <loom.20110607T013117-867@post.gmane.org>
	<loom.20110607T033841-550@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dan Gindikin <dgindikin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTucB-00078M-81
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab1FGLi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 07:38:26 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39212 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab1FGLiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 07:38:25 -0400
Received: by yie30 with SMTP id 30so855546yie.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0MxnfFjkZitAmfRm5Q/jEnqX3sWXHqxzFwYq7VogqU4=;
        b=UUmo1LOZE4DdriGiYuJ9d2ffgHC7qiZvhQw0p+WrXimj7Ow+8DpGQtgXhfkWxtE+L8
         UuL9B1iIei/vNQKplYrpCLcWkVwgBkoPZQAoH4l+mVUNFLg2u2DPrLC+Nm9pWZ3C9R6z
         pX1ugbV1lalIIj7LMSXkRrsCKCT7tGr4shJG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VzwKPdXmlVjLIDgSqTg0UsIXZMw7O/tkXFkr3zeWevoRCW52VCLL0OEm476wM7JLnq
         LZlprwilgp/gT7Q9lyCRTcY8XmbcFlf31AQyY+RnOnOZ9S0xoPMs3h4IMksGixmoW7PP
         klOt+Fq0TyD+C8E6cnKT3bBrfjXbkCN1/PCTs=
Received: by 10.236.80.10 with SMTP id j10mr286123yhe.262.1307446705096; Tue,
 07 Jun 2011 04:38:25 -0700 (PDT)
Received: by 10.147.83.2 with HTTP; Tue, 7 Jun 2011 04:38:25 -0700 (PDT)
In-Reply-To: <loom.20110607T033841-550@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175199>

On Tue, Jun 7, 2011 at 3:40 AM, Dan Gindikin <dgindikin@gmail.com> wrote:
> Dan Gindikin <dgindikin <at> gmail.com> writes:
>
> http://1dan.org/git-blameall

I see that you added this tool to the Git Tools wiki page:

https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#git-blameall

Great!

Thanks,
Christian.
