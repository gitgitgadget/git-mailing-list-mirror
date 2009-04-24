From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: git submodule delete
Date: Fri, 24 Apr 2009 06:33:57 +0200
Message-ID: <49F14135.70500@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 24 06:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxDEy-0007hn-Jh
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 06:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbZDXEkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 00:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbZDXEkr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 00:40:47 -0400
Received: from 2.mail-out.ovh.net ([91.121.26.226]:53347 "HELO
	2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751625AbZDXEkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 00:40:46 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2009 00:40:46 EDT
Received: (qmail 9915 invoked by uid 503); 24 Apr 2009 05:11:44 -0000
Received: from gw2.ovh.net (HELO mail186.ha.ovh.net) (213.251.189.202)
  by 2.mail-out.ovh.net with SMTP; 24 Apr 2009 05:11:44 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 24 Apr 2009 04:33:55 -0000
Received: from agrenoble-152-1-18-201.w82-122.abo.wanadoo.fr (HELO ?192.168.10.12?) (nicolas@morey-chaisemartin.com@82.122.17.201)
  by ns0.ovh.net with SMTP; 24 Apr 2009 04:33:53 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.1b3pre) Gecko/20090223 Thunderbird/3.0b2
X-Ovh-Tracer-Id: 4697535888382091230
X-Ovh-Remote: 82.122.17.201 (agrenoble-152-1-18-201.w82-122.abo.wanadoo.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.518192/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117408>

Hi,

I recently started working with submodule using git.
It's working great however I've been missing a git submodule delete commands to get rid of submodule I don't want in my project anymore.
Is there any reason why there is no such command (over no one has done it yet) ?
Is there another simple way to remove a submodule?

If not, I'll make (at least try) to make the necessary patches.

Nicolas
