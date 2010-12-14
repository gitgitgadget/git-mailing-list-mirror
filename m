From: aerosmith <parvata@rocketmail.com>
Subject: how to create a diff in old file new file format (for code reviews)
Date: Mon, 13 Dec 2010 16:07:37 -0800 (PST)
Message-ID: <1292285257962-5832810.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 01:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSIi3-0005ZM-IU
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 01:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758521Ab0LNAZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 19:25:25 -0500
Received: from 216-139-236-26.aus.us.siteprotect.com ([216.139.236.26]:46478
	"EHLO sam.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757399Ab0LNAZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 19:25:24 -0500
X-Greylist: delayed 1065 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2010 19:25:24 EST
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <parvata@rocketmail.com>)
	id 1PSIQb-0005Yt-Vz
	for git@vger.kernel.org; Mon, 13 Dec 2010 16:07:37 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163606>


Hi,

I am trying to create a diff such that the original file (entire file) is
saved something like file1.h.old and the new modified file as file1.h.new. I
have read the various options for git-diff* tools but could not find one
such utility. All I get is the removals and additions as a diff. Does anyone
know how to create one with the help the available git utils? The only
method that I can think of is to do everything manually. Any help w.r.t.
this is really appreciated. Thanks in advance.
-- 
View this message in context: http://git.661346.n2.nabble.com/how-to-create-a-diff-in-old-file-new-file-format-for-code-reviews-tp5832810p5832810.html
Sent from the git mailing list archive at Nabble.com.
