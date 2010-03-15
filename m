From: jateeq <jawad_atiq@hotmail.com>
Subject: Identifying the commit ID from which a repo was cloned
Date: Mon, 15 Mar 2010 14:06:23 -0700 (PDT)
Message-ID: <27910384.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 22:07:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHV4-0008Uo-0A
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936814Ab0COVG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:06:29 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48025 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936825Ab0COVGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:06:25 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NrHUV-0008Im-Nn
	for git@vger.kernel.org; Mon, 15 Mar 2010 14:06:23 -0700
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142250>


Hello,

Once I clone, make changes and commit several times, I need to determine how
many commits were made (and list them) since the repository was cloned. Does
git remember this commit, and is there a command that can do this, or do I
have to store the commit ID when i clone? 

Thank you,
Jawad
-- 
View this message in context: http://old.nabble.com/Identifying-the-commit-ID-from-which-a-repo-was-cloned-tp27910384p27910384.html
Sent from the git mailing list archive at Nabble.com.
