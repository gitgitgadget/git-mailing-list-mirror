From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] [PATCH] Modify Highlight Color at File Context View.
Date: Sat, 4 Oct 2008 08:19:43 +0200
Message-ID: <e5bfff550810032319s57a0cd52m37aeb8d801019150@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
	 <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net>
	 <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net>
	 <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A217@zch01exm23.fsl.freescale.net>
	 <e5bfff550809270547n15a210e3y386278db00966945@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9605EA4E@zch01exm23.fsl.freescale.net>
	 <e5bfff550809302347r59621e09sdea5c679ef3794c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Li Frank-B20596" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 08:24:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km0Z8-00080e-OL
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 08:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbYJDGTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 02:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYJDGTq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 02:19:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:16137 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYJDGTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 02:19:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1283993fgg.17
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 23:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Gx4DhvmY1het+0dmhRyk3Xf7BEjDE8yvcw/pD9m4A1M=;
        b=I//9omWO/qJVKGEm2bEK18VLRKRGcMFh/SuL0Z7T5G7x1+XEBttSZEvSuhAT9C8047
         Irc4/YcAfjkgF4zR7SUlFeJM2owwi2Spq9I/slDte8j6ob4ZDPa4FcTsuSJ/dD7MAZjR
         875AtkJIN/AGwTMx7kT7G7nmClgAyPF9xvoQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fo0sivwuozp49cwBLHPAfAgO935ULYhuuCWFtGEY261i8BOAZ8gFa4rSLZ1+YYWkvn
         bNdJpvl8t4yodz4O1suCMepnSZuOIMl0ZSMkAP2pbCgPIq62oDVcnflYWaWdUgNlHkdQ
         4QYQrIVAxy4u8z7yxwdfutZVqvtqUlwcaGXeA=
Received: by 10.181.22.1 with SMTP id z1mr1543110bki.30.1223101183844;
        Fri, 03 Oct 2008 23:19:43 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Fri, 3 Oct 2008 23:19:43 -0700 (PDT)
In-Reply-To: <e5bfff550809302347r59621e09sdea5c679ef3794c8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97465>

On Wed, Oct 1, 2008 at 8:47 AM, Marco Costalba <mcostalba@gmail.com> wrote:
> On Mon, Sep 29, 2008 at 3:27 AM, Li Frank-B20596 <Frank.Li@freescale.com> wrote:
>> Marco:
>>
>>          I don't get my patch by git-pull.
>>          There are not my patch at
>> http://git.kernel.org/?p=qgit/qgit4.git;a=summary.
>>
>> best regards
>> Frank Li
>> ________________________________
>
> I have pushed to my local repo, I will be able to push to public repo
> only this week end.
>

Ok. Now is pushed to public repo.

Frank, are you sure it works? for me it does not seem to make any difference.

Marco
