From: Jan Engelhardt <jengelh@medozas.de>
Subject: git-remote rm and multiple remotes
Date: Sun, 10 Aug 2008 11:23:27 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0808101122570.1727@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 17:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCmU-00071y-Kg
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 17:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbYHJPX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 11:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYHJPX3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 11:23:29 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:36134 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbYHJPX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 11:23:28 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id B90CC18032C9B; Sun, 10 Aug 2008 17:23:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id AD38A1C415402
	for <git@vger.kernel.org>; Sun, 10 Aug 2008 11:23:27 -0400 (EDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91845>

Hi,


I noticed that git-remote rm can only take one remote at a time, and I 
think this could be improved, so consider this a feature request ;-)


Jan
