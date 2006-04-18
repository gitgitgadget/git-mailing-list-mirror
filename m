From: linux@horizon.com
Subject: Re: GIT_OBJECT_DIRECTORY
Date: 18 Apr 2006 10:10:50 -0400
Message-ID: <20060418141050.7941.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 16:11:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVqvS-00035J-Q9
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 16:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWDROLB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 10:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWDROLB
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 10:11:01 -0400
Received: from science.horizon.com ([192.35.100.1]:62014 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932114AbWDROLA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 10:11:00 -0400
Received: (qmail 7942 invoked by uid 1000); 18 Apr 2006 10:10:50 -0400
To: joern@wohnheim.fh-wedel.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18854>

Just to cover the obvious "is it plugged in?" questions, did you
also "export GIT_OBJECT_DIRECTORY"?  That is, what does
	env | grep GIT_OBJECT_DIRECTORY
produce?
