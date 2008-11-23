From: nadim khemir <nadim@khemir.net>
Subject: Re: Git.pm
Date: Sun, 23 Nov 2008 20:58:11 +0100
Message-ID: <200811232058.11321.nadim@khemir.net>
References: <200811191856.44252.nadim@khemir.net> <20081120083446.GF10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 23 20:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4L6b-0008A2-8j
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 20:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbYKWT53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 14:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758118AbYKWT52
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 14:57:28 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:56813 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758022AbYKWT51 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 14:57:27 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 43630940129
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 20:57:26 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id 1DEC91264ECF
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 20:57:26 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081120083446.GF10544@machine.or.cz>
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101575>

On Thursday 20 November 2008 09.34.46 you wrote:
>   I know it's quite some time since you wrote this mail originally -
> have you read the Lea's thread I have recommended? What is your current
> plan?

>   I think the current rough consensus in the Git community is to go with
> Lea's design and implementation after extending it with a nice way to
> run arbitrary Git commands. This is also desirable since then we can use
> her patches to make gitweb use Git.pm.

Hi,

Yes I read Lea's thread. My current plan is to:
	- not rush
	- analyse where the different modules are used and how (and document it)
	- understand the process of working with the git team
	- tell my fellow perl developers about this (done, so far very good response)
	- confer with the people having git related modules (a few)
	- gather ideas for what nededs to be changed (not much this far)
	- put a development strategy in place
	- understand the test mechanisms you've been using so far
	- pray hard to any helping deity and get real

Cheers, Nadim.
