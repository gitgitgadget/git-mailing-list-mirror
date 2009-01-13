From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: stg coalesce -> squash?
Date: Tue, 13 Jan 2009 17:41:57 +0100
Message-ID: <20090113164157.GA20143@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMmMf-0003FX-FW
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbZAMQmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 11:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbZAMQmE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:42:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3430 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbZAMQmD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 11:42:03 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LMmKz-0005FX-00; Tue, 13 Jan 2009 16:41:57 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105510>

Would it be a good idea to rename "stg coalesce" to "stg squash"?
That's the term git uses, and it's shorter, easier to spell, and
easier to say. coalesce is still not in any released version of StGit,
so now would be a good time to do it if we wanted to.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
