From: William Morgan <wmorgan-git@masanjin.net>
Subject: Re: git-walkthrough-add script
Date: Fri, 04 Jan 2008 10:31:03 -0800
Message-ID: <1199471454-sup-4786@south>
References: <1199426431-sup-6092@south> <20080104072650.GA24685@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JArQW-0007SK-DY
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYADSh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbYADSh0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:37:26 -0500
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:42330 "EHLO
	nlpi015.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbYADSh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 13:37:26 -0500
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi015.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m04IbOVs014643
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 12:37:24 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JArJv-0002mb-Vu
	for git@vger.kernel.org; Fri, 04 Jan 2008 10:31:04 -0800
In-Reply-To: <20080104072650.GA24685@coredump.intra.peff.net>
User-Agent: Sup/0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69593>

Excerpts from Jeff King's message of Thu Jan 03 23:26:50 -0800 2008:
> It didn't work for me, since the diff parsing failed to match my
> particular colors (I needed /^.....diff/ instead of /^....diff/). I
> suspect the color matching needs to be more flexible to be generally
> useful.

Fixed, thanks.

> However, I'm not clear what advantages this has over "git add -p".

A better interface. (Where by "better", I mean, behaves how I personally
prefer.)

-- 
William <wmorgan-git@masanjin.net>
