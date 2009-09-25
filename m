From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 15:18:37 +0100
Message-ID: <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
	 <4ABC9C5D.5030202@viscovery.net>
	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
	 <4ABCCFE4.6070202@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 16:18:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrBdF-0003EU-4i
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 16:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbZIYOSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 10:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZIYOSf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 10:18:35 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:51826 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZIYOSf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 10:18:35 -0400
Received: by ewy7 with SMTP id 7so2603165ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8rZMjmBKlqQ/TtoH5iApVBhPrTd/UpBhmymRhdJv8VU=;
        b=nJ0pVoe1JxMF+AdjWZGUVTfJcjenLB2yYvAOzS2ZuMAJhOVbQres4mWz56Jzn/swjQ
         r+JrLqQzTWY4nkdD80oheYzKGUq42Js5NZq51gRtEZQbrIaBf1ei725TUbdarKkDJ9aH
         vETA3Xca6AIYPsGKA6dss54wIIqAQ4fzRnybQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tJi99+oxWJES1SwUsOnQxOjhvHPS4aYKkHeAsnbudTWVqkFW1wtQO62ZeqqlFayzCP
         qai8vTTJWCYTNh0UtZ/jix4b8y+wPFRmFsNEI03ubZRnzqiXXIKzS2cVwegKFbyPOll1
         sQSdI1l03O4tgHURfvoNiE9iz6hyhjt4L3EB8=
Received: by 10.216.90.14 with SMTP id d14mr39147wef.30.1253888317965; Fri, 25 
	Sep 2009 07:18:37 -0700 (PDT)
In-Reply-To: <4ABCCFE4.6070202@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129087>

On Fri, Sep 25, 2009 at 15:12, Johannes Sixt <j.sixt@viscovery.net> wrote:
>
> Does that work?
>

No it doesn't.

I had already C:\Program Files\Git\cmd in path, probably added by
msysgit installation.
