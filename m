From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [QGIT4 PATCH 0/6] Some UI Improvements
Date: Mon, 23 Jul 2007 22:52:38 +0200
Message-ID: <200707232252.39456.kumbayo84@arcor.de>
References: <200707232232.39546.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4tX-0002pI-3c
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934082AbXGWUwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbXGWUwj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:52:39 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:59180 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759391AbXGWUwi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:52:38 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id C240C24B247;
	Mon, 23 Jul 2007 22:52:36 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id ACDAF345DCC;
	Mon, 23 Jul 2007 22:52:36 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 8123D1BF385;
	Mon, 23 Jul 2007 22:52:36 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53484>

On Monday 23 July 2007 22:32, Peter Oberndorfer wrote:
> Hi,
> the initial reason for this patches is that here on my system qgit4 looks like this
> http://img77.imageshack.us/my.php?image=qgit4strangewindowgi0.png
> which is a bit suboptimal for viewing patches :-)
> this is on a standard qt 4.3 from gentoo
> 
> While i was there i removed the same problem in the custom action editor
> and removed some unneed empty space
> 
> Actually locally i removed even more empty space, like around the main tab view
> and inside the main tab view.
> If anyone wants me to remove that too, i would be happy to send more patches
> 
> [QGIT4 PATCH 1/6] update patchview.ui with new qt designer
> 	When i edit the .ui files with the QT designer it updates some unrelated parts.
> 	Because of this i split the update into a separate patch so the real changes are obvious.
> 	Feel free to collapse them if you want
> 
> [QGIT4 PATCH 2/6] change size policy of the patch viewer to expanding
> 	this fixes the problem from the screenshot above
> 
> [QGIT4 PATCH 3/6] update patchview.ui with new qt designer
> 	same reason as patch 1
> 
> [QGIT4 PATCH 4/6] change size policy of splitter which contains the list and the textbox
> 	fix same problem in custom action editor
> 
> [QGIT4 PATCH 5/6] remove empty space below "diff to" header in patch view
> [QGIT4 PATCH 6/6] remove empty space below button bar in file view
> 	these remove some more empty space which i personally find useless
> 	Apply if you like them
> 
> If you want i can provide more screenshots of how patches change appearance.
> 
> Greetings Peter
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
hmm, kmail moved Signed-off-by in patches to mail headers,
because there was no message text before it.

so here is a
Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
for all my qgit patches

Greetings Peter
