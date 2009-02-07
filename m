From: James Davidson <james@greycastle.net>
Subject: Re: RPM to GIT tree integration?
Date: Fri, 6 Feb 2009 21:57:47 -0800
Message-ID: <20090207055747.GA5788@greycastle.net>
References: <b2cdc9f30902060905mb605a93oe8f9cc5795f3e008@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVi5w-0000D0-N5
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZBGH5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbZBGH5f
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:57:35 -0500
Received: from defout.telus.net ([204.209.205.13]:45522 "EHLO defout.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbZBGH5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:57:35 -0500
Received: from priv-edtnaa07.telusplanet.net ([66.183.54.107])
          by priv-edtnes28.telusplanet.net
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090207055816.UJS1538.priv-edtnes28.telusplanet.net@priv-edtnaa07.telusplanet.net>;
          Fri, 6 Feb 2009 22:58:16 -0700
Received: from localhost.localdomain (d66-183-54-107.bchsia.telus.net [66.183.54.107])
	by priv-edtnaa07.telusplanet.net (BorderWare Security Platform) with ESMTP id 73D70810382F134B;
	Fri,  6 Feb 2009 22:58:15 -0700 (MST)
Received: from legolas.localdomain ([10.8.0.6])
	by localhost.localdomain (8.14.3/8.14.3) with ESMTP id n175wEgj016840;
	Fri, 6 Feb 2009 21:58:15 -0800
Received: by legolas.localdomain (Postfix, from userid 500)
	id EE8DA90385B; Fri,  6 Feb 2009 21:57:47 -0800 (PST)
Mail-Followup-To: Alex Bennee <kernel-hacker@bennee.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <b2cdc9f30902060905mb605a93oe8f9cc5795f3e008@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108828>

On Fri Feb 06, 2009 at 05:05:49PM +0000, Alex Bennee <kernel-hacker@bennee.com> wrote:
> This is a wild shot in the dark but I thought I'd better ask in case
> some one has. Has anyone created a script/tool that can take a src RPM and
> apply it's patches (in sequence) to an existing GIT tree?

This may be what you are looking for:
http://www.gnome.org/~federico/news-2008-07.html#rpm2git

> In my case I just want a GIT tree for a vendor kernel. I could just
> prep an SRC RPM and commit the thing wholesale into GIT and start
> hacking but then I'd loose all the history benefits.

There is also a "How to use rpm2git" screencast:
http://blip.tv/file/1155469

-- 
James Davidson                     (o_   
james@greycastle.net               //\
http://moria.greycastle.net/       V_/_
