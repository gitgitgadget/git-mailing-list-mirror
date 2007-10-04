From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 03:33:52 +0700
Message-ID: <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 22:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdXOV-0003Zz-7V
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 22:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbXJDUdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 16:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXJDUdy
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 16:33:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:15379 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbXJDUdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 16:33:54 -0400
Received: by nz-out-0506.google.com with SMTP id s18so275196nze
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Qwp6soAW3BzvXPQ+FIcJBCdyL0hvfsqZuWR7bFhEpwY=;
        b=fveKFyrJl7K75oXNYUPOaq8R+l/wSTqyRMSaIoMEuydpCvkIAcxbVmyDDr+0NuxYl7KJfb3rkvshkevM+HX2iNRvYaF/i7cWLjfvVnSJXJlvulVNdK5WhWARJGHUFS8tNmT0vxYUhBa59fxB/4CUbfLY9FwDn9P1dqyt+HvbsuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qtI24cXsAUlN0MsQ5lPjMZnD4/sbsNS1oa/hnlClsJCReoR9o8AvKK+XWLw5X9PgLymmhniKF2Z6QX+7W9/8RccK/Y6ALabWA8Z2p+l+0pCGlr6bg7vZ0kFsGEbh9C1RIKtDAXZXkdSgn2A7XiapB71jnwTfjvBlJ+x8Lw3E74E=
Received: by 10.65.135.19 with SMTP id m19mr14188978qbn.1191530032823;
        Thu, 04 Oct 2007 13:33:52 -0700 (PDT)
Received: by 10.64.24.18 with HTTP; Thu, 4 Oct 2007 13:33:52 -0700 (PDT)
In-Reply-To: <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59999>

On 10/4/07, Wincent Colaiuta <win@wincent.com> wrote:
> > Am I wrong?
>
> About it being a majority, yes, I suspect so.
>

Maybe in the next survey we should include question "do you usually do
'git commit' or 'git commit -a'" :-)

-- 
Duy
