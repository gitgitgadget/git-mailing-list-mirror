From: William Morgan <wmorgan-git@masanjin.net>
Subject: Re: git-walkthrough-add script
Date: Fri, 04 Jan 2008 16:02:43 -0800
Message-ID: <1199491057-sup-5588@south>
References: <1199426431-sup-6092@south> <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 01:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAwbc-0000uz-If
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 01:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbYAEAJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 19:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbYAEAJN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 19:09:13 -0500
Received: from nlpi001.sbcis.sbc.com ([207.115.36.30]:18255 "EHLO
	nlpi001.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbYAEAJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 19:09:13 -0500
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi001.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m0509A95032671
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 18:09:11 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JAwUt-0001l7-At
	for git@vger.kernel.org; Fri, 04 Jan 2008 16:02:43 -0800
In-Reply-To: <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org>
User-Agent: Sup/0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69617>

Excerpts from Pedro Melo's message of Fri Jan 04 15:26:41 -0800 2008:
> You script asks me to add all the changes in the same file at once.

It shouldn't. The whole point is to walk through and allow selection on
a per-hunk basis.

Maybe I'm parsing the output of git diff incorrectly and not picking up
hunk boundaries? Would you mind sending the output of a git diff that
results in this behavior?

-- 
William <wmorgan-git@masanjin.net>
