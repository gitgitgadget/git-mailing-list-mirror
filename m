From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 0/6] cogito: compatibility with OS X
Date: Sun, 17 Jul 2005 22:50:30 -0400
Message-ID: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 04:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuLiM-0008DH-9d
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 04:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVGRCuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 22:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGRCuc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 22:50:32 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:29017 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261491AbVGRCua (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 22:50:30 -0400
Received: (qmail 36273 invoked from network); 18 Jul 2005 02:50:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=YAE983dqGFsKU+WKpa6tSHAKAE5o7YKP392qUboOMEy/CK0wjWWCEYfuC0Ng+iLDHlnvpOYhVq9P/1KOGHAkc/DcZZIaGcqGFdIFJkBWi+tdH0zwAoBunlXBsSW3rDERBEdGTT/fqkCqMQYPsINGtDrKhiGMhCtdT3/vSIjl6a8=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp106.mail.sc5.yahoo.com with SMTP; 18 Jul 2005 02:50:29 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a resend of my previous set of patches.

I have updated these patches with Junio's suggestion.

I have also added some documentation, a simple README.osx.

Once you have applied these patches, could you choose one of these 4
options, Junio?

1) send me the result of "make Portfile" on next release
2) attach the result of "make Portfile" to
http://bugzilla.opendarwin.org/show_bug.cgi?id=3949 on next release
3) upload Portfile's along with the .tar.gz's.
4) tell me you're doing none of the above's, and I'll do the process
manually.

2 of these 5 patches are unchanged from the previous post.  I have
attached them anyways to maintain the series.  Please let me know if
this is poor etiquette.

thanks,
Bryan
