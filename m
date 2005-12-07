From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: dotfile support
Date: Wed, 7 Dec 2005 16:43:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512071643110.12524@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com>
 <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
 <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org>
 <42628D1B.3000207@dwheeler.com> <20051207145646.GA9207@tumblerings.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David A. Wheeler" <dwheeler@dwheeler.com>,
	Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
	Morten Welinder <mwelinder@gmail.com>, mj@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 16:46:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek1T2-0001WX-5X
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 16:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVLGPnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 10:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVLGPnz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 10:43:55 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16782 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751150AbVLGPny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 10:43:54 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 55CCB13F94D; Wed,  7 Dec 2005 16:43:53 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 39F9A9DC48; Wed,  7 Dec 2005 16:43:53 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 22E6F9DC30; Wed,  7 Dec 2005 16:43:53 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 52E2913F94D; Wed,  7 Dec 2005 16:43:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20051207145646.GA9207@tumblerings.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13328>

Hi,

On Wed, 7 Dec 2005, Zack Brown wrote:

> What's the status of dotfile support?

In the current git repository, ".gitignore" is a versioned file.

Hth,
Dscho
