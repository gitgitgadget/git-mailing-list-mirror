From: Henk <henk_westhuis@hotmail.com>
Subject: Msysgit 1.6.2 cannot clone from network drive
Date: Thu, 19 Mar 2009 10:33:05 -0700 (PDT)
Message-ID: <1237483985187-2504254.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 18:35:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkM8s-0006rI-E4
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbZCSRdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbZCSRdI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:33:08 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38590 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZCSRdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:33:07 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LkM77-0006D4-6J
	for git@vger.kernel.org; Thu, 19 Mar 2009 10:33:05 -0700
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113796>


I recently installed Msysgit 1.6.2 and noticed that using this version I
cannot clone from (mapped) network drive anymore. This does work in Msysgit
1.6.1. I double checked this on the computer of a coworker.

We use Windows Vista Professional and are using active directory. Is this a
known bug? Currently I am forced to switch back to version 1.6.1 and I
consider falling back to this version in GitExtensions.
-- 
View this message in context: http://n2.nabble.com/Msysgit-1.6.2-cannot-clone-from-network-drive-tp2504254p2504254.html
Sent from the git mailing list archive at Nabble.com.
