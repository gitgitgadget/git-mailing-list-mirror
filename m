From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: list all dirty files in working directory
Date: Thu, 5 May 2005 23:32:56 +0200
Message-ID: <20050505213256.GQ20994@cip.informatik.uni-erlangen.de>
References: <20050505212152.GP20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 05 23:27:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTnrS-0005J3-9C
	for gcvg-git@gmane.org; Thu, 05 May 2005 23:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEEVc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 17:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVEEVc7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 17:32:59 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37044 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261917AbVEEVc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 17:32:58 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j45LWvS8000348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 5 May 2005 21:32:57 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j45LWuUR000347
	for git@vger.kernel.org; Thu, 5 May 2005 23:32:56 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050505212152.GP20994@cip.informatik.uni-erlangen.de>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

* Thomas Glanzmann <sithglan@stud.uni-erlangen.de> [050505 23:24]:
> is there another way than call 'checkout-cache -a' and parse the output?
> Maybe a command which lists one dirty file per line?

of course I meant parsing the output of 'update-cache --refresh'.

	Thomas
