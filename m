From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Can't create a bare repository
Date: Mon, 13 Jun 2011 08:36:20 -0700
Message-ID: <864o3tkakr.fsf@red.stonehenge.com>
References: <loom.20110613T172618-580@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlo <mr.spoon21@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 17:36:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW9Bk-0006lR-UF
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 17:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001Ab1FMPgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 11:36:24 -0400
Received: from lax-gw09.mailroute.net ([199.89.0.109]:55912 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750864Ab1FMPgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 11:36:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw09.mroute.net (Postfix) with ESMTP id 25D77328006;
	Mon, 13 Jun 2011 15:36:21 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw09.mroute.net (Postfix) with ESMTP id 509911384A2;
	Mon, 13 Jun 2011 15:36:20 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 3CAF44DBC; Mon, 13 Jun 2011 08:36:20 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.8.3; tzolkin = 6 Akbal; haab = 11 Zotz
In-Reply-To: <loom.20110613T172618-580@post.gmane.org> (Carlo's message of
	"Mon, 13 Jun 2011 15:29:05 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175716>

>>>>> "Carlo" == Carlo  <mr.spoon21@gmail.com> writes:

Carlo> I'm just starting using Git and I want to use it mainly for web
Carlo> development. I'm following this guide:

Carlo> http://toroid.org/ams/git-website-howto

Carlo> (anyway, better suggestions are really appreciated) I'm at the
Carlo> point where I have to create a bare repository on the server, but
Carlo> when I give the command "git init --bare" I get this output:

Carlo> usage: git-init [-q | --quiet] [--template=<template-directory>] [--shared]

Carlo> It seems like it's not a valid command.

Time to upgrade your git from something that was released after May 28
of 2008.  That was three years ago. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
