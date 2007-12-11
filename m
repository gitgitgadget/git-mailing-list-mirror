From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 16:03:00 +0100
Message-ID: <20071211150300.GB23609@diana.vm.bytemark.co.uk>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com> <20071211142347.GA22879@diana.vm.bytemark.co.uk> <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:04:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26eW-0000YY-Bu
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbXLKPDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 10:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbXLKPDG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:03:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2014 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbXLKPDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:03:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J26dQ-0006BF-00; Tue, 11 Dec 2007 15:03:00 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67867>

On 2007-12-11 14:27:08 +0000, Catalin Marinas wrote:

> This would only affect people using the source tarball. The rpm and
> deb packages should be fine.

Ah, they don't run the install script?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
