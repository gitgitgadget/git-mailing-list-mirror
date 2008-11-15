From: "Pau Garcia i Quiles" <pgquiles@elpauer.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 11:28:39 +0100
Message-ID: <3af572ac0811150228k291b8850idc34cb474f455aa7@mail.gmail.com>
References: <491DE6CC.6060201@op5.se>
	 <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
	 <491EA1CC.9020605@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 11:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1IPd-00076S-IG
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 11:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYKOK2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 05:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbYKOK2m
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 05:28:42 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:6310 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbYKOK2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 05:28:41 -0500
Received: by yx-out-2324.google.com with SMTP id 8so770698yxm.1
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 02:28:40 -0800 (PST)
Received: by 10.64.242.4 with SMTP id p4mr1882025qbh.84.1226744919802;
        Sat, 15 Nov 2008 02:28:39 -0800 (PST)
Received: by 10.64.203.1 with HTTP; Sat, 15 Nov 2008 02:28:39 -0800 (PST)
In-Reply-To: <491EA1CC.9020605@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101057>

> Shawn posted the exact text. The spirit of that license is that anyone can
> use an unmodified version of the library for whatever they want, but it's
> illegal to link non-GPL software to an altered version of the library. That
> is, the git community will get all changes back while other projects can
> use the official version of the library without having to worry about
> licensing issues. EvilCompany cannot make changes to the library and then
> link non-GPL'd software to their changed version. They can do that if they
> send their library changes upstream and then only use them once they're
> considered "official" though.

Do you mean if I write a patch to libgit2, send it upstream and make
it public on my website but it is not accepted upstream, I cannot link
my modified libgit2 version (i. e. libgit2 + my patch) to my non-GPL
software? It looks insane to me: I wrote the patch and made it public
but you guys did not accept it!

--
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
