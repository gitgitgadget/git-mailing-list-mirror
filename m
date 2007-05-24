From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGIT and conflicts
Date: Thu, 24 May 2007 18:40:38 +0200
Message-ID: <20070524164038.GA27661@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu May 24 17:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrFXh-0000qB-Cb
	for gcvg-git@gmane.org; Thu, 24 May 2007 17:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbXEXPry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 May 2007 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbXEXPry
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 11:47:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4758 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXEXPry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 11:47:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HrGMg-0007Di-00; Thu, 24 May 2007 17:40:38 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48271>

The current behavior of StGIT is to not use the index for conflicts
like git does. What advantages does this have that are great enough to
motivate a deviation from the git behavior?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
