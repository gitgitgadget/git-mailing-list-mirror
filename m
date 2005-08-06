From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.81
Date: Sat, 6 Aug 2005 14:53:23 -0700 (PDT)
Message-ID: <20050806215323.86191.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Aug 06 23:53:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1Wbu-0002jz-Rn
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 23:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbVHFVxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbVHFVxd
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 17:53:33 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:28252 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263596AbVHFVxb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 17:53:31 -0400
Received: (qmail 86193 invoked by uid 60001); 6 Aug 2005 21:53:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KJHDUuo1qFvXYvtJpxkJAkjs9NY6pWZ85SVoPThZ+rr7JVWwHepwlcgoXDOhPPowJgJ+erWYyFpdtTfHF0o5WTetCJz7NC/do4J5CPmP+eS1cDcM5rDVw+/X11tlXinssHt990gxZxn4Ji+c0hB53kRvk0go3Z6dU/foAPR89zo=  ;
Received: from [151.38.101.231] by web26303.mail.ukl.yahoo.com via HTTP; Sat, 06 Aug 2005 14:53:23 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi all,

  this is a fix release, mainly to accomodate the new 'A' flag instead of 'N'
 in git-diff-tree format.

Some little new stuff too, complete changelog below:

- added move back/forward in selection history

- added "hyperlinks" SHA1's in commit messages

- fix cursor position in in commit messages when changing rev

- use GIT_DIR when available to fetch refs

- accomodate new git-diff-tree 'A' insted of 'N' flag format

- added save/restore of diff and file window's geometry


First two ideas, that I read today from the list,
 are very cool, were fun to implement ;-).


Download link is:
http://prdownloads.sourceforge.net/qgit/qgit-0.81.tar.bz2?download


Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
