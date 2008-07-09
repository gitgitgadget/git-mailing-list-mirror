From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git protocol specification
Date: Wed, 9 Jul 2008 20:45:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807092044120.4010@eeepc-johanness>
References: <48750231.4020805@rubyisawesome.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Tom Werner <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGefn-0006q8-M5
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 20:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbYGISov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbYGISov
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 14:44:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:39219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752648AbYGISou (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 14:44:50 -0400
Received: (qmail invoked by alias); 09 Jul 2008 18:44:48 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp062) with SMTP; 09 Jul 2008 20:44:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dlfFLf7GdTXi6Y5YDlZlL69nbjJ/6lkIbqTOjz2
	DDfT6DmAoqGUHH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <48750231.4020805@rubyisawesome.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87906>

Hi,

On Wed, 9 Jul 2008, Tom Werner wrote:

> I'm working on a flexible Erlang replacement for git-daemon and would 
> like to know if there is a specification available for the protocol that 
> git-upload-pack and git-receive-pack use.

How about Documentation/technical/pack-protocol.txt?

Ciao,
Dscho
