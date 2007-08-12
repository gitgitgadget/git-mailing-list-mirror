From: Christian Stimming <stimming@tuhh.de>
Subject: Re: git-gui i18n / 0.9.x plans
Date: Sun, 12 Aug 2007 22:08:10 +0200
Message-ID: <200708122208.11307.stimming@tuhh.de>
References: <20070731012804.GZ20052@spearce.org> <Pine.LNX.4.64.0707311136540.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJjg-00056d-Ly
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759459AbXHLUIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759448AbXHLUIZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:08:25 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:42657 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758154AbXHLUIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 16:08:24 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l7CK8IRW003223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 12 Aug 2007 22:08:18 +0200
Received: from [192.168.2.102] (p549002F8.dip0.t-ipconnect.de [84.144.2.248])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l7CK8GCW030376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 22:08:17 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0707311136540.14781@racer.site>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55717>

Am Dienstag, 31. Juli 2007 12:47 schrieb Johannes Schindelin:
> On Mon, 30 Jul 2007, Shawn O. Pearce wrote:
> > Regarding future development for the off-in-the-future 0.9.0 release I'd
> > like to see the i18n work merge in before we do anything else major to
> > git-gui.

That sounds very good. Of course I'm very interested in having a i18n'ized 
git-gui available as soon as possible. In the git-gui-i18n.git code I think 
we've by now covered really all of the strings that appear throughout the 
program. Thanks to Johannes' maintenance work, the i18n patches are based on 
your (almost) latest master. Once the translation will actually be accepted 
into git-gui.git, I will also spend some weeks on final polish for the 
glossary and the German translation. I think it will be possible for you to 
offer at least a few language in complete translations in a 0.8.x release.

> Very good!  As it happens, I pushed an update this morning.
> temp-rebase-to-shawns-master is the branch which forward-ported all
> patches to the current master of git-gui.git.
>
> As I understand, Christian will find and mark all strings lacking [mc ...]
> and update the .pot file.  Then we'll kindly ask the good translators
> (thanks everyone!) to review the changes, and after that I'll prepare some
> submittable patch series (no need to have several patches per language).

Yes, this is how this should work. I'm looking forward to a fully i18n'ized 
git-gui! Thanks for this great program.

Christian
