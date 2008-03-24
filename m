From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: faster egit history page and a pure java "gitk" so
Date: Mon, 24 Mar 2008 14:31:08 +0000
Message-ID: <200803241431.08633.robin.rosenberg@dewire.com>
References: <20080324092726.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:32:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdnjA-0007XN-NP
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 15:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759736AbYCXObe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759734AbYCXObe
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 10:31:34 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1385 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753746AbYCXObd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 10:31:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 46378802659;
	Mon, 24 Mar 2008 15:31:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sjoI+i2XS5cf; Mon, 24 Mar 2008 15:31:31 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C601A800784;
	Mon, 24 Mar 2008 15:31:31 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080324092726.GQ8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78041>

M=C3=A5ndagen 24 March 2008 09.27.26 skrev Shawn O. Pearce:
> OK, so I decided a few weeks back that the history page was not fast
> enough.  I think I've spent the past 3 weeks writing true revision
> machinary for jgit, and now connecting it up to a UI visualizer.
>
>   git://repo.or.cz/egit/spearce.git plotter
>
> The history page has been completely replaced.  I saw Roger has
> some patches against the current history page.  :-|

Did you lose compare?

Ok, found it, but it only shows one file in the compare editor, so I ca=
nnot=20
walk through all changes in the commit with Ctrl-. and Ctrl-,

-- robin
