From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: call external editor from git-gui?
Date: Fri, 10 Aug 2007 17:30:08 +0200
Message-ID: <20070810153008.GA31759@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 17:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJWRP-000779-13
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 17:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbXHJPaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 10 Aug 2007 11:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757745AbXHJPaO
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 11:30:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1308 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbXHJPaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 11:30:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IJWRF-0008La-00; Fri, 10 Aug 2007 16:30:09 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55545>

git-gui is very good at composing commits. But for writing the actual
commit message -- especially if it's long and needs paragraph
reflowing, indentation, and so on -- I vastly prefer emacs over
git-gui's text field.

It seems to me like it would be straightforward to have a button or
something to launch the user's favorite editor for editing of the
commit message -- after all, git even knows what editor that is!

Unfortunately, with my tcl expertise, this is likely a whole-weekend
project, so I probably won't try to build it myself in the near
future.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
