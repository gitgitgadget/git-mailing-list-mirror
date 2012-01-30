From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 08:02:04 -0600
Message-ID: <20120130140204.GD10618@burratino>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
 <20120130023642.GA14986@burratino>
 <CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
 <7vd3a1erwf.fsf@alter.siamese.dyndns.org>
 <CAMP44s2j+qotu8Fb-1qq9bqHqt+ZF877YzZFXHiMo7Z_BGzTMA@mail.gmail.com>
 <CAH6sp9Of2rT4ESMYj9kC2NPtapsN58X3A0FpHTTZO-kSqpb-2Q@mail.gmail.com>
 <CAMP44s3a05dZqOqpDFDnWQ_C03EODgeP1eRhko-Mc8OjGXj6FQ@mail.gmail.com>
 <CAH6sp9PfVTTNL218syf-MS465M+sP4E8eVxuVCHZC0geE3ezfg@mail.gmail.com>
 <CAMP44s3vXSJaXiQK4X0kNOECzfLFsTo1YeMCtVZ0NWY-CHJ++A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Klaver <fransklaver@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 15:02:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrroL-0006Sz-AQ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 15:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab2A3OCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 09:02:14 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61659 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2A3OCL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 09:02:11 -0500
Received: by ggnb1 with SMTP id b1so1798178ggn.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=U0cBDKM4cCa0HvcOqik+kxfyntaoZQ4qwiMXaroSeBI=;
        b=Ceke11Mw6o+GhRXnxp7TsE/SOXfHkrbSsVkrsv37fccdi+k0Uj8ntF8fxJVqqr9i/4
         zrdAxgyqxum/OCYy8YDS96M6avWgbt4YNT5JelvQtGY3+Yn6VGh6823RufOK0JMlRcPa
         ndhHTbrat1zPW7M8/pIOsXQDZk47tdmHV8HjU=
Received: by 10.50.11.202 with SMTP id s10mr1338745igb.25.1327932130766;
        Mon, 30 Jan 2012 06:02:10 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ng9sm6982852igc.3.2012.01.30.06.02.09
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 06:02:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3vXSJaXiQK4X0kNOECzfLFsTo1YeMCtVZ0NWY-CHJ++A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189362>

Felipe Contreras wrote:

> Either way. I'm not going to discuss in this thread any more. I'll
> resend the patches, feel free to comment there.

Good idea.  Just for the record, I'm not happy with any patch until
I've seen the code. ;-)

Thanks,
Jonathan
