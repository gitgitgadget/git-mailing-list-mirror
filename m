From: Xavier Maillard <maillaxa@gmail.com>
Subject: Re: git-blame.el won't run
Date: Tue, 20 Feb 2007 18:28:54 +0100
Message-ID: <4157.1171992534@localhost>
References: <13283.1171492535@localhost> <87mz393mlo.fsf@morpheus.local> <24475.1171920735@localhost> <87abz92rp9.fsf@morpheus.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 18:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJYqG-0003z3-0V
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 18:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbXBTRbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 12:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbXBTRbs
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 12:31:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:2202 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932773AbXBTRbr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 12:31:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so844543uga
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 09:31:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:in-reply-to:references:comments:x-mailer:date:message-id:from;
        b=TbzcNJQv4pIe9aoYXJOebrKPbPvxfmXD3n+isUVwp2r5zXkyjuzz3ugAR89z/gopkq0RLhhZLVoEkgiKEfh3E1no/D5ESZYF/o78EMvYos6tOS203bJhpINGuFfztNn3oFqXCemB+UDrJjfNj7sJJN51Kzi/Di6dXeclXCgqvEU=
Received: by 10.67.121.15 with SMTP id y15mr8422531ugm.1171992706062;
        Tue, 20 Feb 2007 09:31:46 -0800 (PST)
Received: from localhost.zogzog.HOME ( [88.163.173.156])
        by mx.google.com with ESMTP id y7sm11079257ugc.2007.02.20.09.31.44;
        Tue, 20 Feb 2007 09:31:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.zogzog.HOME (8.13.8/8.13.8) with ESMTP id l1KHSsE0004158
	for <git@vger.kernel.org>; Tue, 20 Feb 2007 18:29:04 +0100
In-reply-to: <87abz92rp9.fsf@morpheus.local> 
Comments: In-reply-to =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
   message dated "Tue, 20 Feb 2007 08:50:26 +0100."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40243>

Hi,

> >> Can you please set debug-on-error to t and show me the backtrace you get?
> >
> > Nothing happens. I have to C-g after having waited for a few
> > seconds.
> 
> I'm not sure my instructions were very clear.  Did you try M-x
> git-blame-mode after enabling debug-on-error?

I did it. And I had to kill (C-g) after having waited for several
long seconds.

Xavier
 
