From: roylee17 <roylee17@gmail.com>
Subject: Howto remove accidentally fetched remote tags?
Date: Mon, 8 Dec 2008 19:34:43 -0800 (PST)
Message-ID: <1228793683956-1632369.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 04:36:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9tOF-0005jk-A2
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 04:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbYLIDep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 22:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbYLIDeo
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 22:34:44 -0500
Received: from kuber.nabble.com ([216.139.236.158]:54822 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYLIDeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 22:34:44 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1L9tMx-0000GN-V4
	for git@vger.kernel.org; Mon, 08 Dec 2008 19:34:43 -0800
X-Nabble-From: roylee17@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102594>


Hi,

Is there a convenient way to remove tags which accidentally( forgot adding
--no-tag ) fetched from a remote repo?

Will git add tag namespace( like branch namespace) in the future?
In this case, we can manage tags as convenient as branches.

Thanks.

Roy
-- 
View this message in context: http://n2.nabble.com/Howto-remove-accidentally-fetched-remote-tags--tp1632369p1632369.html
Sent from the git mailing list archive at Nabble.com.
