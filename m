From: nadim khemir <nadim@khemir.net>
Subject: Re: Problem with Git.pm bidi_pipe methods
Date: Sun, 23 Nov 2008 20:03:14 +0100
Message-ID: <200811232003.14428.nadim@khemir.net>
References: <20081024001446.GE17717@plop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 23 20:03:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4KFG-0000tP-VD
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 20:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbYKWTCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYKWTCb
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 14:02:31 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:55960 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884AbYKWTCa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 14:02:30 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 69BB0940129
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 20:02:29 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id 4BBE51264ECF
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 20:02:29 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081024001446.GE17717@plop>
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101573>

On Friday 24 October 2008 02.14.46 Philippe Bruhat (BooK) wrote:
> To be able to call commit-tree from a Perl program, I had to use
> command_bidi_pipe() to pass the message on standard input, and get the
> ...

Hi Philippe, I'm going to take over the Git.pm maintenance and I'd be happy to 
discuss this problem with you (you know whwere to find me right ;) and I'll 
be happy to hear your suggestions too.

Nadim.
