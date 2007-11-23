From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Temporary directories getting errantly added into trees
Date: Fri, 23 Nov 2007 09:21:03 +0100
Message-ID: <20071123082103.GA11236@diana.vm.bytemark.co.uk>
References: <4744FCD9.7020102@vilain.net> <Pine.LNX.4.64.0711221052280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 09:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvTnH-00034W-Ny
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 09:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbXKWIV3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 03:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbXKWIV3
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 03:21:29 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2922 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbXKWIV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 03:21:28 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IvTmZ-0002yV-00; Fri, 23 Nov 2007 08:21:03 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711221052280.27959@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65874>

On 2007-11-22 10:55:00 +0000, Johannes Schindelin wrote:

> But I don't know about QGit, StGit, etc...

I don't think StGit relies on the name of any file outside .git. (It
does pollute the root of the worktree with some temp files of its own,
though -- but not across invocations.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
