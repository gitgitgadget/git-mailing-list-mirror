From: Jordan Lewis <lewis.1378@gmail.com>
Subject: Re: Git for collaboration on RDF data
Date: Fri, 11 Mar 2016 16:34:04 +0000 (UTC)
Message-ID: <loom.20160311T172300-746@post.gmane.org>
References: <CALX5DUhUO9fM4SZ6F-Qof6JgDaWCaDmw+8ba-eT7iwD7v_7H0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 17:40:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeQ6o-00026u-EU
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 17:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbcCKQkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 11:40:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:45854 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549AbcCKQkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 11:40:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aeQ6d-0001yz-HF
	for git@vger.kernel.org; Fri, 11 Mar 2016 17:40:03 +0100
Received: from 50-246-88-25-static.hfc.comcastbusiness.net ([50-246-88-25-static.hfc.comcastbusiness.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 17:40:03 +0100
Received: from lewis.1378 by 50-246-88-25-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 17:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 50.246.88.25 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288689>

Hello Mark,

I realize this is an old post, but I was looking into doing exactly what you are
 talking about. I did some research into JGIt to see if I could leverage any of
that code to create an RDF Git-like experience. I came to the conclusion that
I would either need to extend a lot of that codebase or create my own. I was
leaning towards creating my own solution.

I was wondering what you ended up doing for your case? Did you find any
external libraries to help accomplish this? Was it a completely custom
solution?

Any pointers or advice would be greatly appreciated.

Cheers,
Jordan Lewis
