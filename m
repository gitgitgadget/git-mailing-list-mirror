From: Stephan Hennig <mailing_list@arcor.de>
Subject: [ANNOUNCE] vc bundle v0.41 -- version control for TeX and friends
Date: Tue, 15 Apr 2008 19:52:39 +0200
Message-ID: <fu2q46$bm3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 20:10:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlpNE-0002fD-Is
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 19:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbYDORye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 13:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYDORy3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 13:54:29 -0400
Received: from main.gmane.org ([80.91.229.2]:48123 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbYDORy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 13:54:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlpMN-0003Le-SW
	for git@vger.kernel.org; Tue, 15 Apr 2008 17:54:24 +0000
Received: from dialin-212-144-219-146.pools.arcor-ip.net ([212.144.219.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 17:54:23 +0000
Received: from mailing_list by dialin-212-144-219-146.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 17:54:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-212-144-219-146.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79610>

The vc bundle
-----------------------------------
This is a script based approach to version control for TeX
documents.  It works more reliably than keyword substitution
based approaches, since it tracks all files in a working
copy, not only .tex files.

The vc bundle works with LaTeX and plain TeX.  Currently,
Bazaar, Git and Subversion are supported.


What's special about the vc bundle?
-----------------------------------
* Common version control packages for LaTeX use keyword
  substitution to access revision information.  That
  approach doesn't work reliably in the presence of
  non-.tex files, e.g., graphics or graphic sources that
  are processed by an external tool.
* The author is unaware of any alternative version control
  packages for plain TeX.
* The author is unaware of any alternative (La)TeX version
  control packages that support Bazaar or Git.


Getting the software
-----------------------------------
The latest version of the vc bundle can be found at CTAN:support/vc.

<URL:http://www.ctan.org>

Happy TeXing!
Stephan Hennig
