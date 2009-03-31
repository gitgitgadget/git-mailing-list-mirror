From: iware <Adrian.Klingel@illumaware.com>
Subject: Force a new version of a file without merge?
Date: Tue, 31 Mar 2009 08:45:54 -0700 (PDT)
Message-ID: <1238514354979-2563750.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 17:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LogC2-00014O-2I
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 17:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbZCaPp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 11:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZCaPp5
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 11:45:57 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38381 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbZCaPp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 11:45:57 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1Log9y-0001OP-W2
	for git@vger.kernel.org; Tue, 31 Mar 2009 08:45:54 -0700
X-Nabble-From: Adrian.Klingel@illumaware.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115269>


There's a really old bad version of a file that I want to completely overwrite. It keeps merging and removing what I want to put out there.

Is there a way to completely replace a file at HEAD in a remote repository without merging?


-- 
View this message in context: http://n2.nabble.com/Force-a-new-version-of-a-file-without-merge--tp2563750p2563750.html
Sent from the git mailing list archive at Nabble.com.
