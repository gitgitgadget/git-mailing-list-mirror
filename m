From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] add --porcelain option to git-push
Date: Tue, 23 Jun 2009 20:41:24 +0200
Message-ID: <200906232041.25102.markus.heidelberg@web.de>
References: <20090622214032.GC19364@coredump.intra.peff.net> <20090623011001.GA15352@cthulhu> <4A40EF9C.7000706@xiplink.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJAxo-0007nT-4B
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 20:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbZFWSl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbZFWSl5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 14:41:57 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:44370 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbZFWSl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 14:41:56 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id ED8BF1011325A;
	Tue, 23 Jun 2009 20:41:11 +0200 (CEST)
Received: from [89.59.79.99] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MJAvf-00005G-00; Tue, 23 Jun 2009 20:41:11 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <4A40EF9C.7000706@xiplink.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+6C8fECrNNE4A5LPn8vIIFZE3HlMev4BW/rb2J
	y0gt0ISkh5GX5BjZZf0jJj5U6OzZsQUOcKDwam9hgoQxymdD1f
	H5BECtLKB+8yjQRI0dWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122108>

Marc Branchaud, 23.06.2009:
> Shouldn't this option be named "--plumbing" since it's making 'git
> push' act like plumbing?

git-blame already has --porcelain
