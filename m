From: William Morgan <wmorgan-git@masanjin.net>
Subject: Re: git-walkthrough-add script
Date: Fri, 04 Jan 2008 18:54:02 -0800
Message-ID: <1199500828-sup-502@south>
References: <1199426431-sup-6092@south> <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org> <20080105010011.GV29972@genesis.frugalware.org>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 04:01:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAzHO-0003tL-KS
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 04:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbYAEDA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 22:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbYAEDA1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 22:00:27 -0500
Received: from nlpi001.sbcis.sbc.com ([207.115.36.30]:9080 "EHLO
	nlpi001.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbYAEDA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 22:00:26 -0500
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi001.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m0530Pa2022071
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 21:00:25 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JAzAg-0006wX-9f
	for git@vger.kernel.org; Fri, 04 Jan 2008 18:54:02 -0800
In-Reply-To: <20080105010011.GV29972@genesis.frugalware.org>
User-Agent: Sup/0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69634>

Excerpts from Miklos Vajna's message of Fri Jan 04 17:00:11 -0800 2008:
> you might want to have a look at dg record
> (http://git.frugalware.org/repos/pacman-tools/darcs-git.py) which does
> this for you.

That's very similar. But I wasn't trying to mimick the darcs interface
exactly, just steal the parts I liked. For example, I don't actually
like being forced to commit immediately after staging some changes;
often I like to git diff --cached first.

Also, mine has color support. :)

-- 
William <wmorgan-git@masanjin.net>
