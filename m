From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach the git wrapper about --name-rev and --name-rev-by-tags
Date: Sat, 29 Jul 2006 14:47:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607291446400.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060524131022.GA11449@linux-mips.org> 
 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>  <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>  <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
  <20060525131241.GA8443@linux-mips.org>  <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0607280952200.4168@g5.osdl.org> 
 <Pine.LNX.4.63.0607282042470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0607290543h12b70c74q54a1fbfc3c8e3b7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-2068666142-1154177223=:29667"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 14:47:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6oDm-0005RV-4X
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 14:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWG2MrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 08:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWG2MrH
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 08:47:07 -0400
Received: from mail.gmx.net ([213.165.64.21]:30664 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932127AbWG2MrF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 08:47:05 -0400
Received: (qmail invoked by alias); 29 Jul 2006 12:47:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 29 Jul 2006 14:47:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0607290543h12b70c74q54a1fbfc3c8e3b7e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24425>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-2068666142-1154177223=:29667
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 29 Jul 2006, Nguyn Thái Ngc Duy wrote:

> On 7/29/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > You are probably right. But _I_ want to know that e.g. commit
> > a025463bc0ec2c894a88f2dfb44cf88ba71bb712 is really tags/v1.4.0^0~27^2.
> > Both are immutable, but the latter is nicer to people than to computers.
> I think so too. I had requested a similar feature on the git survey
> and was surprised to see this patch. I'd appreciate it.

Now, guess three times where the idea comes from. ;-)

Ciao,
Dscho

---1148973799-2068666142-1154177223=:29667--
