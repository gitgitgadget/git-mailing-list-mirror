From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: cg-seek messed me up
Date: Tue, 31 May 2005 16:45:07 +0200
Message-ID: <20050531144506.GC6706@cip.informatik.uni-erlangen.de>
References: <20050531143318.GB27047@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 16:46:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd7yv-0003ip-FL
	for gcvg-git@gmane.org; Tue, 31 May 2005 16:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVEaOqr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 10:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVEaOqr
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 10:46:47 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:65417 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261550AbVEaOpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 10:45:21 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4VEj7S8021740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 May 2005 14:45:07 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4VEj7sI021739;
	Tue, 31 May 2005 16:45:07 +0200 (CEST)
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050531143318.GB27047@tumblerings.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
this is exactly why I don't use it at the moment. My own frontend does
before every pull/push/merge/commit a 'look for dirty files and look for
uncommited deltas'.

	Thomas
