From: weloki <weloki@gmail.com>
Subject: Can't seem to commit
Date: Sat, 4 Dec 2010 08:33:04 -0800 (PST)
Message-ID: <1291480384128-5803287.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 04 17:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POv34-0000EE-CD
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 17:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab0LDQdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 11:33:06 -0500
Received: from kuber.nabble.com ([216.139.236.158]:47686 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab0LDQdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 11:33:04 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <weloki@gmail.com>)
	id 1POv2m-0001nP-KS
	for git@vger.kernel.org; Sat, 04 Dec 2010 08:33:04 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162895>


There is probably an easy solution to this but I'm seeing something really
weird...
I can't seem to commit anything to my new branch. When I try to commit it
just says "no changes added to commit (use "git add" and/or "git commit
-a")"
When I try to do git add it doesn't seem to do anything.
When I try to push it says "Everything up-to-date", but when I look at the
branch on github my files aren't there.
Strangely I was able to do everything fine with a different branch I created
afterwards.
-- 
View this message in context: http://git.661346.n2.nabble.com/Can-t-seem-to-commit-tp5803287p5803287.html
Sent from the git mailing list archive at Nabble.com.
