From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT unhelpfulness
Date: Tue, 22 May 2007 16:15:45 +0200
Message-ID: <20070522141545.GA15546@diana.vm.bytemark.co.uk>
References: <20070522111603.GH4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 22 15:18:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqUG7-0008MJ-5c
	for gcvg-git@gmane.org; Tue, 22 May 2007 15:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488AbXEVNS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 09:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756564AbXEVNS1
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 09:18:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2136 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488AbXEVNS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 09:18:27 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HqV9N-0004Af-00; Tue, 22 May 2007 15:15:45 +0100
Content-Disposition: inline
In-Reply-To: <20070522111603.GH4489@pasky.or.cz>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48105>

On 2007-05-22 13:16:03 +0200, Petr Baudis wrote:

> stg pull: Rebasing would possibly lose data

I agree. I've also hit this problem, but with "stg rebase".

I just submitted a bug for this:

  https://gna.org/bugs/index.php?9181

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
