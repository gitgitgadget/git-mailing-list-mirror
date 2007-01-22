From: Jimmy Tang <jtang+2007-01@tchpc.tcd.ie>
Subject: Re: commit message columns
Date: Mon, 22 Jan 2007 21:23:04 +0000
Message-ID: <20070122212304.GA17243@vual.tchpc.tcd.ie>
References: <20070122211902.GC6614@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 22:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9741-00049O-5e
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 22:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXAVVuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 16:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbXAVVuu
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 16:50:50 -0500
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:33983 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbXAVVut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 16:50:49 -0500
X-Greylist: delayed 1653 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 16:50:48 EST
Received: from localhost (localhost [127.0.0.1])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id 4CDEE2BA67;
	Mon, 22 Jan 2007 21:23:04 +0000 (GMT)
Received: from tabaet.tchpc.tcd.ie ([127.0.0.1])
	by localhost (tabaet.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08640-01; Mon, 22 Jan 2007 21:23:03 +0000 (GMT)
Received: from vual.tchpc.tcd.ie (vual.ipv6.tchpc.tcd.ie [IPv6:2001:770:10:500:2b0:d0ff:fefe:d7d2])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id B38102BA4A;
	Mon, 22 Jan 2007 21:23:03 +0000 (GMT)
Received: from localhost (LOCALHOST [127.0.0.1])
	by vual.tchpc.tcd.ie (Postfix) with ESMTP id F2F7E19118;
	Mon, 22 Jan 2007 21:23:04 +0000 (GMT)
Received: from vual.tchpc.tcd.ie ([127.0.0.1])
 by localhost (vual.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17091-08; Mon, 22 Jan 2007 21:23:04 +0000 (GMT)
Received: by vual.tchpc.tcd.ie (Postfix, from userid 8176)
	id E03D819123; Mon, 22 Jan 2007 21:23:04 +0000 (GMT)
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20070122211902.GC6614@fieldses.org>
User-Agent: Mutt/1.4.1i
X-Useless-Header: I am the Master Blaster!, the faster blaster master blaster faster blaster
X-Operating-System: Linux vual.tchpc.tcd.ie 2.4.26
X-Wii-Number: 6053 9064 7271 7948
X-Wii-Nick: zaku
X-Virus-Scanned: by amavisd-new at tchpc.tcd.ie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37460>

Hi,

On Mon, Jan 22, 2007 at 04:19:02PM -0500, J. Bruce Fields wrote:
> Uh, I feel like I must be missing something simple here--when editing
> commit messages, you'd like the editor (vim in my case) to wrap text
> sooner than it normally would, since commit messages are displayed
> indented.  What's the easiest way to ensure this always happens?

vim -c 'set tw=60'

where 60 is the column width. dont know how useful that is to you though


Jimmy.


-- 
Jimmy Tang
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/ | http://www.tchpc.tcd.ie/~jtang
