From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] allow file list editing during cg-commit
Date: Mon, 09 May 2005 10:27:09 +0200
Message-ID: <1115627229.8949.132.camel@pegasus>
References: <20050509041459.GA13475@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 10:20:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV3UJ-0004tG-Cb
	for gcvg-git@gmane.org; Mon, 09 May 2005 10:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVEII0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 04:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVEII0u
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 04:26:50 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:24494 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261165AbVEII0s
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 04:26:48 -0400
Received: from pegasus (p5487DDD1.dip.t-dialin.net [84.135.221.209])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j498S4WX011065
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 9 May 2005 10:28:05 +0200
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050509041459.GA13475@gate.ebshome.net>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Eugene,

> I just started playing with cogito and failed to find _easy_ way to
> select which files will be committed and which won't. cg-commit seems
> to support specifying file list in command line, but this isn't very
> convenient when the list is big.

do you know any SCM native text interface that supports such a thing? In
general this is done by high-level GUI based interfaces to the SCM or a
special Emacs mode etc.

Regards

Marcel


