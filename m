From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Using pickaxe to track changed symbol CR4_FEATURES_ADDR
Date: Mon, 5 Jun 2006 12:26:27 +0200
Message-ID: <20060605102627.GB24346@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 05 12:26:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnCI6-0002B1-Tu
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 12:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWFEK0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 06:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWFEK03
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 06:26:29 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:19656 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750873AbWFEK03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 06:26:29 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id CD17530624; Mon,  5 Jun 2006 12:26:27 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21314>

Hello,
I am looking for the symbol CR4_FEATURES_ADDR which must be gone in one
of the last kernel revision. Now how I do use pickaxe to track any
changes that involve my missing symbol? Or is there a better way to
track that change down?

        Thomas
