From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sat, 21 Jul 2007 20:57:18 +0200
Message-ID: <4d8e3fd30707211157l1be243basfb259082b7aa8160@mail.gmail.com>
References: <7vodi7vtct.fsf@assigned-by-dhcp.cox.net>
	 <200707210815.l6L8F2Da032066@mi0.bluebottle.com>
	 <7vr6n2upwv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-2022-JP?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?=" 
	<nanako3@bluebottle.com>, "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Christian Stimming" <stimming@tuhh.de>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 20:57:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICK9A-0008Qi-Gn
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 20:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166AbXGUS5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 14:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762198AbXGUS5W
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 14:57:22 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:28598 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758364AbXGUS5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 14:57:20 -0400
Received: by nz-out-0506.google.com with SMTP id s18so975305nze
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 11:57:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E96SUb3P0I+icIKtIC6ZVf7td91CnISu/S73QrmB1l4sktpX4MaqCwVzkI/oNnPG43mtYipkZUoDIiatAfgKSEDwapx3NX7gsApYBEyO8XCvucNXz4KNpLAan6Wvy3VuFDSacI8wn6piIcfxLS9tNTJlyhhP96R9TxcX8fccQn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sD0DrgLxTo0M1Z4qU5ZRC9vkfgndBAMTB0/x91F8XFmHQSugQ8QNJfDyuDAjMtajRbG0Q0RqsOjsbQ2yzEP4CIJ0lxlGs3NmRKCA196zfFPXUuEvNtY09nJiPVz1+x/WuA4GbkZ+KlVOCXSzU13+1QOI+oH2KCrG22kMSeVVxRQ=
Received: by 10.142.79.15 with SMTP id c15mr121018wfb.1185044238965;
        Sat, 21 Jul 2007 11:57:18 -0700 (PDT)
Received: by 10.142.86.9 with HTTP; Sat, 21 Jul 2007 11:57:18 -0700 (PDT)
In-Reply-To: <7vr6n2upwv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53180>

On 7/21/07, Junio C Hamano <gitster@pobox.com> wrote:

paolo@paolo-desktop:~/git-gui-i18n$ ls
git-gui.sh  GIT-VERSION-GEN  lib  Makefile  po


>  - Run 'make' once, to get po/git-gui.pot generated;

paolo@paolo-desktop:~/git-gui-i18n$ make
GITGUI_VERSION = 0.8.GITGUI
    * new locations or Tcl/Tk interpreter
    GEN git-gui
    BUILTIN git-citool
    INDEX lib/

paolo@paolo-desktop:~/git-gui-i18n$ ls po/
de.msg  de.po  glossary.csv  ja.msg  ja.po

There is "po/git-gui.pot" file in my repository.

Am I doing something wrong?

Thanks!

Ciao,
-- 
Paolo
"Tutto cio' che merita di essere fatto,merita di essere fatto bene"
Philip Stanhope IV conte di Chesterfield
