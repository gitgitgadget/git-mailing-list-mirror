From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] [PATCH] Modify Highlight Color at File Context View.
Date: Sun, 5 Oct 2008 09:34:29 +0200
Message-ID: <e5bfff550810050034p59f08945x4256927b54633e66@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
	 <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net>
	 <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A217@zch01exm23.fsl.freescale.net>
	 <e5bfff550809270547n15a210e3y386278db00966945@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9605EA4E@zch01exm23.fsl.freescale.net>
	 <e5bfff550809302347r59621e09sdea5c679ef3794c8@mail.gmail.com>
	 <e5bfff550810032319s57a0cd52m37aeb8d801019150@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A45A@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Li Frank-B20596" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 09:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmO9w-0004Aq-SF
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 09:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbYJEHeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 03:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbYJEHeb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 03:34:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:56387 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbYJEHeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 03:34:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1546945fgg.17
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HHXJLJgmPBhPtWpgd3zbYcFl4vtqUei4LJPmvSfuAiQ=;
        b=JW9I7qYHgazYLwu80kXT9xRBgQ5AFUB9YVoUwscvGpwzbRMbI19DIZsJ5HTmQcI4i6
         AHcj45ADDMYsf9z3Wt5snVARqp91938V3YBCQGbiSO/PKMPEMjQ8nNM8D1qk3PSaskW/
         yp03yEcXiyMAeE32Twstavhw1hDOMgKfu5UHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ViY5O4CxiODAxqm4JdZqaFmDwtLZEiOIh1pJ1b7sPrBdKcTVOXMWD2v58yjt3jHQ0s
         EXL4EJuF4lxyheqS7vNaQCqV7r6Jkj4B/P8QfHTYdIV4zDpL1Vxrv9oQOuSHsQpaBogm
         y6zk/tWTNgUmt97BgP7QpXQbtv5+G8bp2copU=
Received: by 10.180.254.18 with SMTP id b18mr2457027bki.43.1223192069410;
        Sun, 05 Oct 2008 00:34:29 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Sun, 5 Oct 2008 00:34:29 -0700 (PDT)
In-Reply-To: <7FD1F85C96D70C4A89DA1DF7667EAE9607A45A@zch01exm23.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97498>

On Sat, Oct 4, 2008 at 4:32 PM, Li Frank-B20596 <Frank.Li@freescale.com> wrote:
>
> It should be setBackground(back), not setForeground(back);
>

Ahaaaa! My bad!

Sorry for this. Fix pushed.

Thanks
Marco
