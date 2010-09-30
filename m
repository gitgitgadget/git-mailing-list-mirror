From: Andy <hoangtu69@yahoo.com>
Subject: How to get a remote branch
Date: Wed, 29 Sep 2010 21:13:07 -0700 (PDT)
Message-ID: <1285819987771-5586541.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 06:13:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1AWF-0003m0-Be
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 06:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118Ab0I3ENJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 00:13:09 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33028 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab0I3ENI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 00:13:08 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <hoangtu69@yahoo.com>)
	id 1P1AW3-0001nK-P6
	for git@vger.kernel.org; Wed, 29 Sep 2010 21:13:07 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157629>


Here's my directory structure

origin -> HEAD
         -> master
         -> develop

Right now if I issue command

git clone https://abc.com/xzy.git and do git branch 

then I have an asterisk next to master.

I want to get branch develop, what command should I issue please?
-- 
View this message in context: http://git.661346.n2.nabble.com/How-to-get-a-remote-branch-tp5586541p5586541.html
Sent from the git mailing list archive at Nabble.com.
