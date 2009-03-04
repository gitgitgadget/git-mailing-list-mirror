From: Henk <henk_westhuis@hotmail.com>
Subject: Lock binairy files in Git
Date: Wed, 4 Mar 2009 05:56:48 -0800 (PST)
Message-ID: <1236175008046-2422894.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 14:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lerc6-0001H7-Em
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 14:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZCDN4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 08:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZCDN4u
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 08:56:50 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38607 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbZCDN4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 08:56:49 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1Leraa-0004zc-1d
	for git@vger.kernel.org; Wed, 04 Mar 2009 05:56:48 -0800
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112212>


In our current version control system we lock binairy files when we edit
them. This way other developers know when a file is being edited. Is there
something simular in Git? Or is there another method to let others now I am
currently editing a file?

We need this only for binairy files, because they cannot be merged. 

Henk
-- 
View this message in context: http://n2.nabble.com/Lock-binairy-files-in-Git-tp2422894p2422894.html
Sent from the git mailing list archive at Nabble.com.
