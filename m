From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] packed delta git
Date: Thu, 19 May 2005 20:38:10 +0200
Message-ID: <20050519183810.GF8105@cip.informatik.uni-erlangen.de>
References: <200505171857.46370.mason@suse.com> <200505191428.52238.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 19 20:39:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYptj-00005w-Ry
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVESSiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVESSiP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:38:15 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:56975 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261200AbVESSiL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 14:38:11 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4JIcAS8021903
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 19 May 2005 18:38:10 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4JIcAJ3021902
	for git@vger.kernel.org; Thu, 19 May 2005 20:38:10 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200505191428.52238.mason@suse.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Chris,

> size (du -sh .git)              2.5G                  227M

wow that beats bitkeeper in size. What is missing to actual use such a
approach in a distributed environment?

	Thomas
