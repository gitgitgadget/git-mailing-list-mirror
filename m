From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Live Gentoo Ebuild (Git via Git on Gentoo)
Date: Mon, 23 Mar 2009 13:47:07 +0100
Message-ID: <49C784CB.5030903@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 13:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lljhn-0006ue-9D
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 13:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbZCWMzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 08:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbZCWMzH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 08:55:07 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:42501 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbZCWMzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 08:55:06 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2009 08:55:05 EDT
Received: from [85.179.13.124] (helo=[192.168.0.3])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1LljYZ-0005De-Ok
	for git@vger.kernel.org; Mon, 23 Mar 2009 13:47:07 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114299>

It's in the "sping" overlay, get it through ..

  layman -a sping
  autounmask -n dev-util/git-9999-r3
  emerge git -v



Sebastian
