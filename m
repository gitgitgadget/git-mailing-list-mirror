From: Eric Raible <raible@gmail.com>
Subject: Re: AW: Challenge with Git-Bash
Date: Mon, 19 Jul 2010 18:09:31 +0000 (UTC)
Message-ID: <loom.20100719T200744-692@post.gmane.org>
References: <001d01cb25cb$eb176980$c1463c80$@net> <20100717171303.GB10730@burratino> <008a01cb26a4$4313e360$c93baa20$@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 20:09:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaumk-0002GV-5l
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 20:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760829Ab0GSSJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 14:09:45 -0400
Received: from lo.gmane.org ([80.91.229.12]:42808 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760784Ab0GSSJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 14:09:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oaumb-0002CB-Ih
	for git@vger.kernel.org; Mon, 19 Jul 2010 20:09:42 +0200
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 20:09:41 +0200
Received: from raible by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 20:09:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.86 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151265>

Rainer Lauer <lauerr <at> gmx.net> writes:

> Where is following information stored? Command:  git config --global 
user.name="Rainer Lauer".

The '=' appears in your config file (.git/config), but shouldn't be used
on the comand line.
