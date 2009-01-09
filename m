From: chris@seberino.org
Subject: Curious about details of optimization of object database...
Date: Fri, 9 Jan 2009 09:46:23 -0800
Message-ID: <20090109174623.GC12552@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 18:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLLSV-000485-W2
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 18:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZAIRqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 12:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbZAIRqY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 12:46:24 -0500
Received: from li30-51.members.linode.com ([65.49.60.51]:51559 "EHLO
	seberino.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbZAIRqX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 12:46:23 -0500
Received: by seberino.org (Postfix, from userid 1000)
	id 778B218985; Fri,  9 Jan 2009 09:46:23 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105022>

I'm told a commit is *not* a patch (diff), but, rather a copy of the entire
tree.

Can anyone say, in a few sentences, how git avoids needing to keep multiple
slightly different copies of entire files without just storing lots of
patches/diffs?

cs
