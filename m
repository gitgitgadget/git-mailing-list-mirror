From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Adding custom hooks to a bare repository.
Date: Mon, 28 Jul 2008 13:40:13 +0100
Message-ID: <18071eea0807280540x33940fdej1ac4f48f64d05d4a@mail.gmail.com>
References: <18071eea0807280404w3365748cjcd11f536bf5d27eb@mail.gmail.com>
	 <alpine.DEB.1.00.0807281324350.2725@eeepc-johanness>
	 <18071eea0807280532l69d12e3ehb8377da9d24e035@mail.gmail.com>
	 <alpine.DEB.1.00.0807281438220.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNS2S-000299-UC
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYG1MkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYG1MkP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:40:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:12805 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbYG1MkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:40:14 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5711647wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=O1x2HhX+JOVaI4FXye1fedErnDUYpy4wk7J6nHA5hdg=;
        b=GNQ7JOrDZnehTxjkCwAXz5Os+spmPEFQP2Bq2kMNbmmzDNP2XGG6s21wyz7BO2QBcY
         WopM4m/SxaWszS9taTItNZ5eO/Xt5UM6OCFqzYgYkcVf3Ht+9qMdVr2bBXMzfNhsWwJP
         M+YGEMVJUgggAYRgiFgJWjIxzU6eAOqDb5bJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JExT121TwSVGs8P/+0+MOKjA2c039TnaEZn+zJcQA9LLPbObq6zqJCpAI+eBsSsWEX
         3gsO7JB/LOMbJL3F9mGrOSDsjB7clKaTAQThAUi0XiC6S0kTbePPe7yL7WZYfUUHofdN
         S/golZCchporK6JVgA6aSjUvf7nY5bb6TOQxw=
Received: by 10.143.32.7 with SMTP id k7mr1571443wfj.305.1217248813668;
        Mon, 28 Jul 2008 05:40:13 -0700 (PDT)
Received: by 10.142.104.15 with HTTP; Mon, 28 Jul 2008 05:40:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807281438220.2725@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90454>

2008/7/28 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> For all those reasons, it is better to just commit an executable script in
> your <toplevel>/githooks/post-merge and ask your users to copy it to
> .git/hooks/.

Grand.  Thank you very much.  :)

-- Thomas Adam
