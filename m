From: gglaser <g-glaser@ti.com>
Subject: Git Error: "points nowhere"
Date: Tue, 30 Mar 2010 15:27:33 -0700 (PDT)
Message-ID: <28089341.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 00:27:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwjuP-0007IO-OB
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab0C3W1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 18:27:36 -0400
Received: from kuber.nabble.com ([216.139.236.158]:34154 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab0C3W1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 18:27:36 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NwjuH-00042Z-BL
	for git@vger.kernel.org; Tue, 30 Mar 2010 15:27:33 -0700
X-Nabble-From: g-glaser@ti.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143612>


Whenever I try to run any Git commands, I get the error:
error: refs/remotes/m/f2d704c379fecb5597d0aaab007ee04fc9a83842 points
nowhere!

f2d704c379fecb5597d0aaab007ee04fc9a83842 is the commit ID of a Git tree that
I tried to clone previously. It seems like it is still left in my repository
for some reason.

Any ideas on how to stop this error? Thanks in advance.
-- 
View this message in context: http://old.nabble.com/Git-Error%3A-%22points-nowhere%22-tp28089341p28089341.html
Sent from the git mailing list archive at Nabble.com.
