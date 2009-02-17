From: jidanni@jidanni.org
Subject: Re: Bug#497469: git-gui: child window looks like part of parent
Date: Wed, 18 Feb 2009 05:20:51 +0800
Message-ID: <87iqn8iwuk.fsf_-_@jidanni.org>
References: <20090217204809.4319.qmail@66bf796ad944b2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: 497469@bugs.debian.org
X-From: git-owner@vger.kernel.org Tue Feb 17 22:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZXOa-0000We-3i
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 22:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbZBQVU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 16:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbZBQVUz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 16:20:55 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:42084 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751635AbZBQVUz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 16:20:55 -0500
Received: from jidanni.org (122-127-32-240.dynamic.hinet.net [122.127.32.240])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 85EC6119DEF;
	Tue, 17 Feb 2009 13:20:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110453>

$ git gui blame some_file
Click edit->options.
The "options" window then appears directly on top of the file viewer
window.
It is shifted vertically, but not horizontally.
It needs to be shifted horizontally too.
Or else the user will just click edit->options again, getting into
deep trouble.
GP> Hi, I'm not that much in GUIs.  Can you report upstream?, that'd
GP> be nice.
OK. Cc'ing them. They should see
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=497469 .
