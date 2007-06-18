From: Carlo Wood <carlo@alinoe.com>
Subject: Re: GIT Packages for Debian Etch
Date: Tue, 19 Jun 2007 00:04:41 +0200
Message-ID: <20070618220441.GC13538@alinoe.com>
References: <20070618212524.GC16393@cip.informatik.uni-erlangen.de> <20070618212741.GA5938@artemis.internal.dc7.debconf.org> <20070618214852.GA13538@alinoe.com> <20070618215610.GG16393@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Thomas Glanzmann <thomas@glanzmann.de>,
	LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765680AbXFRWFJ@vger.kernel.org Tue Jun 19 00:05:49 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765680AbXFRWFJ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0PLy-0006VK-L1
	for glk-linux-kernel-3@gmane.org; Tue, 19 Jun 2007 00:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765680AbXFRWFJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 18 Jun 2007 18:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764552AbXFRWEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jun 2007 18:04:51 -0400
Received: from viefep18-int.chello.at ([213.46.255.22]:38961 "EHLO
	viefep16-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753901AbXFRWEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jun 2007 18:04:50 -0400
Received: from mail9.alinoe.com ([62.163.36.229]) by viefep16-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070618220441.XHOJ24784.viefep16-int.chello.at@mail9.alinoe.com>;
          Tue, 19 Jun 2007 00:04:41 +0200
Received: from carlo by mail9.alinoe.com with local (Exim 4.67)
	(envelope-from <carlo@alinoe.com>)
	id 1I0PKz-00054H-El; Tue, 19 Jun 2007 00:04:41 +0200
Mail-Followup-To: Carlo Wood <carlo@alinoe.com>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070618215610.GG16393@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50422>

On Mon, Jun 18, 2007 at 11:56:10PM +0200, Thomas Glanzmann wrote:
> true. But when you run sid you get a newer version of git automatically.
> Sooner or later. And you can always build it yourself. It's a pain in
> the ass until you have all build dependencies installed and all the
> tests pass.

Oh, I already build it before my previous post :p

I just did:

sudo apt-get install libz-dev asciidoc xmlto libexpat1-dev subversion unzip tcl8.4 libsvn-perl libcurl3-dev

after having a peek at git-core_1.5.2.1-1.dsc, and then it did build
just fine immediately.

-- 
Carlo Wood <carlo@alinoe.com>
