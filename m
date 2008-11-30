From: nadim khemir <nadim@khemir.net>
Subject: Re: [RFC] Git Perl bindings, and OO interface
Date: Sun, 30 Nov 2008 14:45:18 +0100
Message-ID: <200811301445.18969.nadim@khemir.net>
References: <200811270258.50898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 14:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6mcD-0004Fh-JD
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 14:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbYK3NoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 08:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYK3NoU
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 08:44:20 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:36927 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751362AbYK3NoT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Nov 2008 08:44:19 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 786C3940030
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 14:44:18 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id 5B94812640A7
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 14:44:18 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811270258.50898.jnareb@gmail.com>
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101972>

On Thursday 27 November 2008 02.58.49 Jakub Narebski wrote:
> ...
>
> 7. Git::Refs
>
>    It is meant to represent references, mainly branches, and be filled
>    using git-for-each-ref... and for example used for ref markers.
>
> There are probably a few things I have forgot about...

Thank you for writing the RFC, it's a very good start. I would like to see 
some strategy for libgit[2] in the RFC. What is your opinion about that?

Nadim.
