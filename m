From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: list all dirty files in working directory
Date: Thu, 5 May 2005 23:21:53 +0200
Message-ID: <20050505212152.GP20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 05 23:16:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTnh4-0003Gs-Bk
	for gcvg-git@gmane.org; Thu, 05 May 2005 23:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEEVWC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 17:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVEEVWC
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 17:22:02 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50866 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261790AbVEEVV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 17:21:56 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j45LLrS8029690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 5 May 2005 21:21:53 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j45LLrYK029689
	for git@vger.kernel.org; Thu, 5 May 2005 23:21:53 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
is there another way than call 'checkout-cache -a' and parse the output?
Maybe a command which lists one dirty file per line?

	Thomas
