From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-svn: importing branches later
Date: Tue, 8 May 2007 10:51:49 +0200
Message-ID: <20070508085149.GB24409@diana.vm.bytemark.co.uk>
References: <20070507190702.GE342@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 10:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlLQN-0007BJ-7V
	for gcvg-git@gmane.org; Tue, 08 May 2007 10:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934675AbXEHIvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 04:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934780AbXEHIvw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 04:51:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2700 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934732AbXEHIvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 04:51:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlLQD-0006ga-00
	for <git@vger.kernel.org>; Tue, 08 May 2007 09:51:49 +0100
Content-Disposition: inline
In-Reply-To: <20070507190702.GE342@ginosko.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46554>

On 2007-05-07 13:07:06 -0600, Michael Hendricks wrote:

> Now I want to import the 'foo' branch from the same SVN repo without
> grabbing all the branches. Any suggestions?

I seem to recall that just adding another "fetch" line to the git-svn
configuration in .git/config will do this for you.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
