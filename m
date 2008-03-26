From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Wed, 26 Mar 2008 20:22:04 +0100
Organization: www.grml.org
Message-ID: <fse7ot$qpl$1@ger.gmane.org>
References: <fs9f0o$jge$1@ger.gmane.org> <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk> <7v1w5zslv5.fsf@gitster.siamese.dyndns.org> <fs9i36$qck$1@ger.gmane.org> <Pine.LNX.4.64.0803250050320.30488@kaos.quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 20:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JebDw-0006jw-ER
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 20:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759299AbYCZTWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 15:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759027AbYCZTWT
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 15:22:19 -0400
Received: from main.gmane.org ([80.91.229.2]:56225 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676AbYCZTWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 15:22:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JebCN-0001IE-Tt
	for git@vger.kernel.org; Wed, 26 Mar 2008 19:22:11 +0000
Received: from 85-127-11-174.dynamic.xdsl-line.inode.at ([85.127.11.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 19:22:11 +0000
Received: from gebi by 85-127-11-174.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 19:22:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 85-127-11-174.dynamic.xdsl-line.inode.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78301>

* Julian Phillips <julian@quantumfyre.co.uk> wrote:

> It would be relatively easy to change the check that prevents you from 
> doing it - but this wouldn't stop any of the nasty things that could 
> ensue.  You might never have a problem with a simple layout, but it could 
> cause mayhem for others with more complicated layouts.

fair enough, thx :)

cu,
michael
-- 
It's already too late!
