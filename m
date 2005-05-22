From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: git-diff-files -z output
Date: Sun, 22 May 2005 19:38:46 +0200
Message-ID: <20050522173846.GB18500@cip.informatik.uni-erlangen.de>
References: <20050522170540.GO15178@cip.informatik.uni-erlangen.de> <7v3bsffadn.fsf@assigned-by-dhcp.cox.net> <20050522172737.GB17570@cip.informatik.uni-erlangen.de> <20050522173243.GA18500@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 19:37:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZuOU-0003Fi-En
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVEVRit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEVRit
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:38:49 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:53453 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261272AbVEVRir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 13:38:47 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MHckS8019027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 17:38:46 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MHckva019026
	for git@vger.kernel.org; Sun, 22 May 2005 19:38:46 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050522173243.GA18500@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

>                 $tmp[0] =~ s/^://g;
                                   ^ -> This is useless.

	Thomas
