From: Alex Ksikes <alex@chiefmall.com>
Subject: faceted search interface
Date: Wed, 03 Feb 2010 04:41:31 -0800
Message-ID: <E1NceXz-0003VA-QG@mail.chiefmall.com>
Reply-To: Alex Ksikes <alex.ksikes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 14:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcfkO-00017A-TK
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 14:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab0BCN6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 08:58:19 -0500
Received: from chiefmall.com ([88.191.78.221]:38499 "EHLO mail.chiefmall.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757283Ab0BCN6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 08:58:19 -0500
X-Greylist: delayed 4602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 08:58:19 EST
Received: from www-data by mail.chiefmall.com with local (Exim 4.63)
	(envelope-from <alex@chiefmall.com>)
	id 1NceXz-0003VA-QG; Wed, 03 Feb 2010 04:41:31 -0800
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138834>

Hi all,

I have just put together a system to automatically build a faceted search interface and search engine from any data. Would you mind having a look at it and letting me know what you think of it?

Here is a particular instance on IMDb (the internet movie database). You can refine by particular categories such as genres, actors or directors with the results ordered by user ratings and number of votes.

http://imdb.cloudmining.net/search?query=(@actor%20Brad%20Pitt)

This IMDb instance was built automatically. All that was needed was to setup the data in a specific format and to optionally customize the look and feel of a search result. In fact the system was also applied to DBLP:

http://dblp.cloudmining.net/search?query=(@venue%20CHI)

The system is called Cloud Mining (http://www.cloudmining.net). Your feedback would be very much appreciated.

Thank you so much,

Alex Ksikes
