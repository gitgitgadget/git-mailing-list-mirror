From: amishera <amishera2007@gmail.com>
Subject: How are the same file modified on different brances stored
 physically?
Date: Mon, 3 Mar 2008 00:16:49 -0800 (PST)
Message-ID: <15799383.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 09:17:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW5rT-0005Dx-6L
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 09:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbYCCIQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 03:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbYCCIQu
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 03:16:50 -0500
Received: from kuber.nabble.com ([216.139.236.158]:55354 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYCCIQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 03:16:49 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1JW5qr-0000wB-6j
	for git@vger.kernel.org; Mon, 03 Mar 2008 00:16:49 -0800
X-Nabble-From: amishera2007@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75907>


Hi,
I am trying to figure out how stuffs work behind the scene. We know that we
can switch branches freely and then work on the switched branch. If the same
file is modified on two branches then how are the two copies of the two
branches saved?
-- 
View this message in context: http://www.nabble.com/How-are-the-same-file-modified-on-different-brances-stored-physically--tp15799383p15799383.html
Sent from the git mailing list archive at Nabble.com.

