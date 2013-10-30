From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Wed, 30 Oct 2013 13:01:00 +0100
Message-ID: <5270F4FC.60900@viscovery.net>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org
To: Nicolas Cornu <ncornu@aldebaran-robotics.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 30 13:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbUSW-00039O-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 13:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab3J3MBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 08:01:07 -0400
Received: from so.liwest.at ([212.33.55.16]:38270 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab3J3MBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 08:01:06 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VbUSK-0005sS-M8; Wed, 30 Oct 2013 13:01:00 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6BA5616613;
	Wed, 30 Oct 2013 13:01:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237014>

Am 10/30/2013 11:58, schrieb Nicolas Cornu:
> This scrollbar is not optional and is useful if there is a lot of tags or
> branches.

If this is the "only" case where the scrollbar is useful, i.e., it would
be handy only once every other week, then it is better to remember that
you can pan around in the window by moving the mouse with the middle mouse
button held down. Vertical screen estate in the commit history pane is too
precious to waste for a scrollbar that is useless most of the time.

-- Hannes
