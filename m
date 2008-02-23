From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 01:44:45 +0000
Message-ID: <20080223014445.GK27894@ZenIV.linux.org.uk>
References: <200802221837.37680.chase.venters@clientec.com> <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chase Venters <chase.venters@clientec.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:45:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjS8-00016E-KE
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbYBWBos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYBWBos
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:44:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36251 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbYBWBor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:44:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.63 #1 (Red Hat Linux))
	id 1JSjRV-0002sH-Qn; Sat, 23 Feb 2008 01:44:45 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74782>

On Sat, Feb 23, 2008 at 02:37:00AM +0100, Jan Engelhardt wrote:

> >do you tend to clone the entire repository repeatedly into a series
> >of separate working directories
> 
> Too time consuming on consumer drives with projects the size of Linux.

git clone -l -s

is not particulary slow...
