From: root <daly@axiom-developer.org>
Subject: Re: builtin-add.c patch
Date: Wed, 10 Dec 2008 14:14:10 -0500
Message-ID: <200812101914.mBAJEAS04718@localhost.localdomain>
References: <200812101238.mBACcWQk023480@axiom-developer.org> <20081210142632.GA4137@myhost>
Reply-To: daly@axiom-developer.org
Cc: daly@axiom-developer.org, git@vger.kernel.org
To: aspotashev@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 10 20:31:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAUlf-0007mU-T4
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 20:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbYLJT30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbYLJT3Z
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:29:25 -0500
Received: from mx-7.zoominternet.net ([24.154.1.26]:46685 "EHLO
	cm-1.zoominternet.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755377AbYLJT3X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 14:29:23 -0500
X-SpamGroup: 2000
X-CM-Cat: Undefined:Undefined
X-CNFS-Analysis: v=1.0 c=1 a=E8rTNAPPKTgA:10 a=9x1qJYSYWOoMgoVr+WVG7Q==:17 a=mUhZWOYJMRPZb-YlFZYA:9 a=CH8Qk3uuwVVzqwNLDkU4wBJbtMoA:4 a=v47ZLdibA2YA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Received: from [24.154.1.45] ([24.154.1.45:48487] helo=pop-2.zoominternet.net)
	by mx-7.zoominternet.net (envelope-from <daly@axiom-developer.org>)
	(ecelerity 2.2.2.30 r(24168)) with ESMTP
	id B6/27-25390-FD310494; Wed, 10 Dec 2008 14:09:19 -0500
Received: (qmail 28630 invoked from network); 10 Dec 2008 19:09:20 -0000
Received: from unknown (HELO localhost.localdomain) ([72.23.19.139])
          (envelope-sender <daly@axiom-developer.org>)
          by pop-2.zoominternet.net (qmail-ldap-1.03) with SMTP
          for <daly@axiom-developer.org>; 10 Dec 2008 19:09:20 -0000
Received: (from root@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id mBAJEAS04718;
	Wed, 10 Dec 2008 14:14:10 -0500
In-reply-to: <20081210142632.GA4137@myhost> (message from Alexander Potashev
	on Wed, 10 Dec 2008 17:26:32 +0300)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102702>

Alexander,

I saw a suggestion that git could be used as a filesystem rather
than as a code repository. I'm looking to convert it for this
purpose to sit underneath Axiom, a computer algebra system written
in common lisp. Basically the idea is that a "close" operation does
a 'git add foo ; git commit'. 

Are you aware of anyone who has used git as a filesystem?

Tim Daly
