From: Jay Renbaum <jrenbaum@hcrest.com>
Subject: Security and permissions in git
Date: Thu, 29 Jan 2009 20:34:38 +0000 (UTC)
Message-ID: <loom.20090129T203050-865@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 21:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSdhc-0003a0-Nu
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 21:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZA2UkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 15:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZA2UkG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 15:40:06 -0500
Received: from main.gmane.org ([80.91.229.2]:50656 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbZA2UkF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 15:40:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LSdgB-0008Lw-7Z
	for git@vger.kernel.org; Thu, 29 Jan 2009 20:40:03 +0000
Received: from 12.173.51.158 ([12.173.51.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 20:40:03 +0000
Received: from jrenbaum by 12.173.51.158 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 20:40:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.173.51.158 (Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107727>

When setting up a public repository is there a way to control who has access 
to various directories within the repository or is everything equal once you 
are in?
