From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: integrity of a repository
Date: Sun, 16 Mar 2008 11:09:52 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080316100952.GC32394@ins.uni-bonn.de>
References: <20080315132645.GC17579@ins.uni-bonn.de> <7v4pb7migk.fsf@gitster.siamese.dyndns.org> <20080316063215.GA6067@ins.uni-bonn.de> <7v8x0jkv8t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 11:10:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Japp9-0004GT-SA
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 11:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYCPKJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 06:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYCPKJ7
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 06:09:59 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:33398 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYCPKJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 06:09:58 -0400
Received: from localhost.localdomain (xdsl-87-78-165-50.netcologne.de [87.78.165.50])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 2649440002DE7;
	Sun, 16 Mar 2008 11:09:57 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JapoO-0004qX-Pq; Sun, 16 Mar 2008 11:09:52 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8x0jkv8t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77358>

* Junio C Hamano wrote on Sun, Mar 16, 2008 at 08:01:38AM CET:
> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
> 
> > OK.  Now, is there a way to quickly ensure that a repository is in a
> > pruned state, short of running 'git gc --prune'?
> 
> "git fsck --full"?

Ahh, good.  Thanks!
Ralf
