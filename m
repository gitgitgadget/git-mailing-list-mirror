From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Hard-linked trees with git?
Date: Tue, 18 Oct 2005 22:18:35 +0200
Message-ID: <m3vezufujo.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Tue Oct 18 22:19:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERxuy-0005yr-Mo
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbVJRUSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 16:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVJRUSi
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 16:18:38 -0400
Received: from khc.piap.pl ([195.187.100.11]:27908 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751485AbVJRUSh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 16:18:37 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 3184D10A61; Tue, 18 Oct 2005 22:18:36 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10226>

Hi,

Are hard-linked working trees possible with git? Anybody doing that?

Or: is it possible to have some constant file timestamps, so that
changing the HEAD to something and returning to the old HEAD
(say, with hard resets) restores the old timestamps?
-- 
Krzysztof Halasa
