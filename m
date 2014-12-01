From: Sergey Organov <sorganov@gmail.com>
Subject: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 14:50:43 +0300
Message-ID: <87zjb78u7g.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 13:00:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvPeL-0001SA-3S
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 13:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbaLAMAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 07:00:08 -0500
Received: from mail.javad.com ([54.86.164.124]:58800 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbaLAMAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 07:00:07 -0500
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Dec 2014 07:00:07 EST
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 1DC116189C
	for <git@vger.kernel.org>; Mon,  1 Dec 2014 11:50:45 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XvPV5-00061D-8K
	for git@vger.kernel.org; Mon, 01 Dec 2014 14:50:43 +0300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260480>

Hello,

$ git help log | grep exit-code
           problems are found. Not compatible with --exit-code.
$

What --exit-code does in "git log"?

-- 
Sergey.
