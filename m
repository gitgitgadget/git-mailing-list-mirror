From: jemmyw <jeremy@boost.co.nz>
Subject: retrospective move
Date: Wed, 4 Feb 2009 00:43:36 -0800 (PST)
Message-ID: <21826423.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 09:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdNX-0001tG-K7
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbZBDIni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZBDInh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:43:37 -0500
Received: from kuber.nabble.com ([216.139.236.158]:58575 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbZBDInh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:43:37 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LUdM8-0004mu-V5
	for git@vger.kernel.org; Wed, 04 Feb 2009 00:43:36 -0800
X-Nabble-From: jeremy@boost.co.nz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108314>


Hi. Awhile ago I copied some files in my local repo then commited. In another
commit I deleted the original files, so essentially I did a mv that git
doesn't know about. Now I'm trying to merge from another branch where
changes have happened to the files in their original locations, and it's
making the merge somewhat difficult. Is there a way to ease this?
-- 
View this message in context: http://www.nabble.com/retrospective-move-tp21826423p21826423.html
Sent from the git mailing list archive at Nabble.com.
