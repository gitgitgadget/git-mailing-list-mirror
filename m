From: Aris Bezas <igoumeninja@gmail.com>
Subject: Problem with add folder to a subdirectory
Date: Sat, 3 Apr 2010 01:26:26 -0700 (PDT)
Message-ID: <28125580.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 10:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxyge-0008U8-1D
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 10:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab0DCI03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 04:26:29 -0400
Received: from kuber.nabble.com ([216.139.236.158]:60603 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab0DCI01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 04:26:27 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NxygU-0004s4-I1
	for git@vger.kernel.org; Sat, 03 Apr 2010 01:26:26 -0700
X-Nabble-From: igoumeninja@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143882>


Hi,
I am new to git and i have a problem. I clone repo from a collaborator and i
want to add some folder to a subdirectory.
When i add a folder to the root dir ($ git add TestFolder) i have no problem
but when i try to put it in a different subdirectory like ($ git add
examples/TestFolder) then with the command ($ git status) i tsake no result
(nothing to commit (working directory clean)).

Thanks for your reply

Aris Bezas Sat, 03 April 2010, 11:26
-- 
View this message in context: http://old.nabble.com/Problem-with-add-folder-to-a-subdirectory-tp28125580p28125580.html
Sent from the git mailing list archive at Nabble.com.
