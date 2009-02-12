From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: gitk and tags
Date: Thu, 12 Feb 2009 18:13:57 +0100
Message-ID: <OF13533D2E.931134C6-ONC125755B.005E1480-C125755B.005EAB59@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 18:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXfGl-0003rI-Lx
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 18:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbZBLRVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 12:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756312AbZBLRVI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 12:21:08 -0500
Received: from gw1.transmode.se ([213.115.205.20]:58568 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbZBLRVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 12:21:07 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2009 12:21:07 EST
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id DA03F33A91
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 18:14:03 +0100 (CET)
X-KeepSent: 13533D2E:931134C6-C125755B:005E1480;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5 December 05, 2008
X-MIMETrack: Serialize by Router on sesr04/Transmode(Release 8.0.2|August 07, 2008) at
 2009-02-12 18:13:58,
	Serialize complete at 2009-02-12 18:13:58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109633>

Is there any way to make gitk display tags when specifying a path?
example: gitk drivers/usb/gadget
will show me all commits that touches this directory but I can't make gitk 
show
me where the tags are so I can see which commits made it into what 
release.

  Jocke
