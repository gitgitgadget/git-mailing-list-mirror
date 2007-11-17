From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: gitk in a bare repo?
Date: Sat, 17 Nov 2007 17:48:14 +0100
Message-ID: <004201c82939$a5bb2840$5267a8c0@Jocke>
References: <004101c8292b$cd4b5d20$5267a8c0@Jocke> <1f6632e50711170806x3d0c73eam7e341e73f637fc83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Matthias Kestenholz'" <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Sat Nov 17 17:48:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItQqS-0005th-94
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 17:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbXKQQsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 11:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbXKQQsT
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 11:48:19 -0500
Received: from mail.transmode.se ([83.241.175.147]:21189 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753504AbXKQQsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 11:48:19 -0500
Received: from Jocke ([84.217.6.210]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 17 Nov 2007 17:48:16 +0100
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <1f6632e50711170806x3d0c73eam7e341e73f637fc83@mail.gmail.com>
thread-index: AcgpM8qlrKXSdsFYQSCypPX/H0Ki/wABa/cA
X-OriginalArrivalTime: 17 Nov 2007 16:48:16.0369 (UTC) FILETIME=[A6855610:01C82939]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65288>

> -----Original Message-----
> From: mk@feinheit.ch [mailto:mk@feinheit.ch] On Behalf Of 
> Matthias Kestenholz
> Sent: den 17 november 2007 17:06
> 
> Hi Joakim,
> 
> 2007/11/17, Joakim Tjernlund <joakim.tjernlund@transmode.se>:
> > How do I tell gitk I am in a bare repo?
> >
> 
> The following command works for me:
> 
> $ ls
> foo.git
> $ GIT_DIR=foo.git gitk &
> 

Ahh, didn't think of that. Tride passing --bare in diffrent ways

Thanks,
        Jocke
