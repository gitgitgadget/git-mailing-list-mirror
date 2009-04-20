From: Andy Lester <andy@petdance.com>
Subject: valgrind
Date: Mon, 20 Apr 2009 13:06:51 -0500
Message-ID: <872ACD6C-B99B-4BE4-BD7C-3A7B3255B3E1@petdance.com>
References: <cover.1240249482u.git.johannes.schindelin@gmx.de> <f62793069ecb99138c435edf37533906c4aae301.1240249482u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvxut-0002Hb-FU
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbZDTSGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 14:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbZDTSGx
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:06:53 -0400
Received: from huggy.petdance.com ([72.14.176.61]:53328 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbZDTSGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 14:06:52 -0400
Received: from alester.flr.follett.com (host3130.follett.com [12.47.12.130])
	by huggy.petdance.com (Postfix) with ESMTP id BC0881BE575;
	Mon, 20 Apr 2009 14:06:51 -0400 (EDT)
In-Reply-To: <f62793069ecb99138c435edf37533906c4aae301.1240249482u.git.johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117014>


On Apr 20, 2009, at 12:44 PM, Johannes Schindelin wrote:

> Found by valgrind.


How are you running valgrind?  Do you have a test suite for it?  A  
make target?

xoa


--
Andy Lester => andy@petdance.com => www.theworkinggeek.com => AIM:petdance
