From: Carlo <mr.spoon21@gmail.com>
Subject: Can't create a bare repository
Date: Mon, 13 Jun 2011 15:29:05 +0000 (UTC)
Message-ID: <loom.20110613T172618-580@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 17:29:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW94v-0003Jz-U8
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 17:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796Ab1FMP3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 11:29:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:44605 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213Ab1FMP3U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 11:29:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QW94n-0003HB-BN
	for git@vger.kernel.org; Mon, 13 Jun 2011 17:29:17 +0200
Received: from 93-39-223-175.ip77.fastwebnet.it ([93.39.223.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 17:29:17 +0200
Received: from mr.spoon21 by 93-39-223-175.ip77.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 17:29:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 93.39.223.175 (Mozilla/5.0 (X11; Linux i686; rv:2.0.1) Gecko/20100101 Firefox/4.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175715>

Hi,
I'm just starting using Git and I want to use it mainly for web development. I'm
following this guide:

http://toroid.org/ams/git-website-howto

(anyway, better suggestions are really appreciated)
I'm at the point where I have to create a bare repository on the server, but
when I give the command "git init --bare" I get this output:

usage: git-init [-q | --quiet] [--template=<template-directory>] [--shared]

It seems like it's not a valid command.

Any idea?
