From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] l10n: de.po: translate 265 new messages
Date: Mon, 21 May 2012 21:44:18 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <3329216.EHqWPidfNL@cs-pc>
References: <1337533755-29399-1-git-send-email-ralf.thielow@googlemail.com> <1825828.hnjW9vybBO@cs-pc> <CAN0XMOKsKRwsrHv=FNKtzydf8_sW6nM7bw2HJu6wT4reR=jujg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: trast@student.ethz.ch, jk@jk.gs, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 21 21:44:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWYX2-0003k4-M2
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 21:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab2EUTog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 15:44:36 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:52247 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab2EUTof (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 15:44:35 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q4LJiL3I032712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 21 May 2012 21:44:21 +0200
Received: from cs-pc.localnet (e176202190.adsl.alicedsl.de [85.176.202.190])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q4LJiKBM027430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 May 2012 21:44:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-21;
	t=1337629461; bh=cVN/SSpa0dkwlZyc+BIakGzpJ4ITbxP/1ia/J6ncyoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ouTyzo8csLV5y98lgYA0V0mcCp8/IICClG0kIp+setMIu5oPh1Bv20rzZCBgMiggm
	 8P8kh4589Ov/acxi/mghGvqsMbCuknrzqdslkzd8wdi4/1MYUcTM5hURdCtbQnRHud
	 OX1J1MULudVnFtQJdWRqcSBLVPnFPwJDVWpuAhT8=
User-Agent: KMail/4.7.3 (Linux/3.0.0-19-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <CAN0XMOKsKRwsrHv=FNKtzydf8_sW6nM7bw2HJu6wT4reR=jujg@mail.gmail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198124>

Am Montag, 21. Mai 2012, 20:02:26 schrieb Ralf Thielow:
> Hi Christian,
> 
> thanks for your review. I agree with you that using a formal addressing
> is better and probably sounds a bit more serious than an informal. However,
> I would put that change in another commit to make it through the whole
> translation,
> because it's probably not a good idea to mix them. This also includes the
> last git.pot update on master. I don't expect big updates on git.pot after
> 1.7.11-rc0 was tagged, so afterwards I start working on this.

Hi Ralf,

this is a very good proposal! Indeed the addressing shouldn't be mixed for 
now. Thanks for picking up the suggestion.

Regards,

Christian
