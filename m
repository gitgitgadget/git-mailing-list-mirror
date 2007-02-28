From: Jeremy Sw <kertejeremy@hotmail.com>
Subject: bug report, error : Unable to find 000000000.....
Date: Wed, 28 Feb 2007 19:24:47 +0000
Message-ID: <BAY120-W200B9984A9E70409399666AE810@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUQF-0001Rn-No
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbXB1TYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbXB1TYt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:24:49 -0500
Received: from bay0-omc2-s4.bay0.hotmail.com ([65.54.246.140]:48258 "EHLO
	bay0-omc2-s4.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932388AbXB1TYs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:24:48 -0500
Received: from BAY120-W20 ([207.46.9.183]) by bay0-omc2-s4.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 28 Feb 2007 11:24:48 -0800
X-Originating-IP: [213.48.73.91]
Importance: Normal
X-OriginalArrivalTime: 28 Feb 2007 19:24:48.0148 (UTC) FILETIME=[1C3A9540:01C75B6E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40993>


By running  # git clone http://intellinuxwireless.org/repos/ipwraw.git
git return an error when trying to Get alternates list.
the error is :
"error: Unable to find 0000000000000000000000000000000000000000 under http://intellinuxwireless.org/repos/ipwraw.git/
Cannot obtain needed object 0000000000000000000000000000000000000000"
apparently caused by a weird architecture of the tree !
there is 4 or 5 diffrents projects, but they have commun files because firmwares are related !
_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE