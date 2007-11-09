From: Andy Whitcroft <apw@shadowen.org>
Subject: git push mirror mode V4 (replacement stack)
Date: Fri, 9 Nov 2007 23:30:41 +0000
Message-ID: <20071109233041.GC301@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:30:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdJN-0002iF-NB
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbXKIXai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbXKIXah
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:30:37 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3504 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbXKIXah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:30:37 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IqdJ5-0006c2-6b; Fri, 09 Nov 2007 23:30:35 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64277>

Following this mail is a complete replacement git push mirror mode
stack (V4).  It folds down all the various patches into a logical
sequence (thanks Dscho).  This stack passes the entire test suite,
and I have been using the same code for real work here.

Please replace what you have in pu with this stack.

-apw
