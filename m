From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Errors pushing tags in "next"
Date: Thu, 22 Mar 2007 19:03:40 -0700 (PDT)
Message-ID: <958071.66875.qm@web31811.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 03:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUZEb-0000tw-6T
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 03:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbXCWCKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 22:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933102AbXCWCKW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 22:10:22 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:37320 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932398AbXCWCKW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 22:10:22 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Mar 2007 22:10:21 EDT
Received: (qmail 67552 invoked by uid 60001); 23 Mar 2007 02:03:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=W/Ie7q/AZCKt1/55c+AZO15vFhn9BLHUaH7wgHfNxCaSOsUMCJl59YnqgpTY7cZ6VElrRcBJslh8C83C4+Z1FJhcuVfAzfH/gGsLQXcTLO1kGszEYrDiKoxpk3c1l0iTqaWD9ateyc/ZpSWpSdLh1xHjjkVlhJyOAy9GlktUo0E=;
X-YMail-OSG: XIuFlSsVM1mFqXgbPHN.G0IRvntGa0TFgCsFW2GlSrqh1YNTBU7Lluati1cu6ufLn6rfD7.IaCWfPMnEvqi7zj5j0TMuPTueTTs2VNk9KrKX0ZQ38rJZf1.X7YhC3ZJnpmCKUPndfS5Qwg--
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Thu, 22 Mar 2007 19:03:40 PDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42897>

Is this of any concern?

### Pushing version 'v2.6.21-rc4' to the masses
fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions
refs/tags/v2.6.21-rc4: 0000000000000000000000000000000000000000 ->
bac6eefe96204d0ad67d144f2511a6fc487aa594

Thanks,
   Luben

P.S.
git --version
git version 1.5.1.rc1.901.gb7f2
