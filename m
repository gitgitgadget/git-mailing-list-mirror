From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] Some suggestion
Date: Fri, 26 Sep 2008 07:15:50 +0200
Message-ID: <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net>
	 <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net>
	 <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Li Frank-B20596" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 07:17:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj5hU-0003Pu-Sr
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 07:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYIZFPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 01:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYIZFPw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 01:15:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:8122 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYIZFPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 01:15:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so532183fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=btD5LmixQGYfN+5MFDUYh+Q6shegO7oEg6Yc96GYZNQ=;
        b=IpDMcDXIixHQLh7/Sq7eS4DTCeLQubeaHq92o403FzZV181wzVe8vtwQUFk6zBXQWw
         NmNW+1zvvao1AfYe7RIMPEGwZ20zCxx5aCxgEZFr4OP0V7JpSAGUMrUZ+KCitM3IGr7u
         r0KL+ZDD5Jkv1Z+Nor0G+WILQt/cSw2lja7xA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=w/Mp0JuQG52oUsGPj2Okez8zaMN2BD9L0xpFygOBdI+Pf4xO4DGDifyaRLJHLHmU8H
         M7u8ANcxG2H5idUwQFra++o1dbk8pOVmlE4n8oNluKS7MKl3WQGtx/u9nv9Cje1ldR+h
         6keJ3eXEacEKs3g8kQaf1axt1aybh1RMe50Rg=
Received: by 10.180.223.8 with SMTP id v8mr485651bkg.53.1222406150146;
        Thu, 25 Sep 2008 22:15:50 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Thu, 25 Sep 2008 22:15:50 -0700 (PDT)
In-Reply-To: <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96825>

On Fri, Sep 26, 2008 at 3:55 AM, Li Frank-B20596 <Frank.Li@freescale.com> wrote:
> Thank you for your support!
> Can I compare with other version at file view?

After selecting with CTRL+RIGHT CLICK as already descrived click on
the file name, you'll be pointed to the part of the diff related to
your file.

Another option is to choose one commit, click on a file name in the
right bottom pane, then press the MAGIC WAND button, then commits will
be reloaded with path limiter and you will see only commits that
modify the selected file. Toggle magic wand button to restore original
view.

> I think highlight author at file view is not high light, can use
> different color?

What is the color you would like ? Possibly in RGB format.

Marco
