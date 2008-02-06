From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: what does @NNN in git-svn branch names mean?
Date: Wed, 6 Feb 2008 17:29:05 +0100
Message-ID: <20080206162905.GA29432@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMn9j-0005wo-Tm
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYBFQ3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 11:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbYBFQ3T
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:29:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4596 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbYBFQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:29:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JMn8z-0007f4-00; Wed, 06 Feb 2008 16:29:05 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72810>

What does it mean when git-svn creates branches with an @ sign and a
Subversion revision number in them? The documentation doesn't say
(and, this being perl, grepping for "@" in git-svn.perl is of little
use!). I'll be happy to write something up if you'll clue me in.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
