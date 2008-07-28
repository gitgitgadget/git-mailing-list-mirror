From: Sam Vilain <sam@vilain.net>
Subject: Update to "Peer Wire Guidelines" on GitTorrent RFC
Date: Mon, 28 Jul 2008 12:30:52 +1200
Message-ID: <488D133C.1090704@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gittorrent@lists.utsl.gen.nz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 02:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNGen-0005E4-07
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 02:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbYG1AbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 20:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756766AbYG1AbG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 20:31:06 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53576 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbYG1AbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 20:31:05 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 6CB3F21C960; Mon, 28 Jul 2008 12:31:02 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.3
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id D1B3F21C95E;
	Mon, 28 Jul 2008 12:30:52 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90380>

During the development of GitTorrent, I was being asked questions that
led me to realise that there wasn't a very good overall view of how the
various proposed GitTorrent messages fit together to make fetches work.

So, I've written a whole lot more on this with a few paragraphs which I
hope will pull it all together.  If you found the RFC previously
indigestable, try reading:

  http://gittorrent.utsl.gen.nz/rfc.html#peer-wire-guidelines

If there are parts which still aren't clear, please ask questions and I
will aim to write more clarification to the specification.

Cheers!
Sam.
