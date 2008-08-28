From: "srinivasan.malligarjunan" <formypersonnel@yahoo.co.in>
Subject: Git clone error
Date: Thu, 28 Aug 2008 05:57:10 -0700 (PDT)
Message-ID: <19199973.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 14:58:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYh4s-0000lV-26
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 14:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYH1M5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 08:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbYH1M5N
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 08:57:13 -0400
Received: from kuber.nabble.com ([216.139.236.158]:57853 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYH1M5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 08:57:13 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KYh3m-0002if-R7
	for git@vger.kernel.org; Thu, 28 Aug 2008 05:57:11 -0700
X-Nabble-From: formypersonnel@yahoo.co.in
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94045>


[root@aspire038 git-1.5.6]# git clone git@github.com:/ayyanar/adva_cms.git
Initialize adva_cms/.git
Initialized empty Git repository in /root/Desktop/git-1.5.6/adva_cms/.git/
The authenticity of host 'github.com (65.74.177.129)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,65.74.177.129' (RSA) to the list of
known hosts.
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
[root@aspire038 git-1.5.6]# git clone
git@github.com:/karthikeyan7585/adva_cms.git
Initialize adva_cms/.git
Initialized empty Git repository in /root/Desktop/git-1.5.6/adva_cms/.git/
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
[root@aspire038 git-1.5.6]# 



The permission denied error is comming . Please help me.
-- 
View this message in context: http://www.nabble.com/Git-clone-error-tp19199973p19199973.html
Sent from the git mailing list archive at Nabble.com.
