From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Re: git-cvsimport BUG: some commits are completely out of phase (but
 cvsps sees them all right)
Date: Mon, 03 Nov 2008 17:03:58 -0200
Organization: DATACOM
Message-ID: <490F4B1E.2080707@datacom.ind.br>
References: <200811022203.41092.fg@one2team.net> <f299b4f30811021421w2ef43792l7514ab3a0506077a@mail.gmail.com> <200811022331.14048.fg@one2team.net> <490F1021.1090002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:06:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx4ji-0001Gt-5t
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYKCTD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYKCTD7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:03:59 -0500
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:46854 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751650AbYKCTD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 14:03:58 -0500
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id C4F7032ADA; Mon,  3 Nov 2008 17:03:56 -0200 (BRST)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id 6776432AD8;
	Mon,  3 Nov 2008 17:03:56 -0200 (BRST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <490F1021.1090002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99980>

Michael Haggerty wrote:
> Francis Galiegue wrote:
>> The plan would be to convert all modules in one go, with no one committing in 
>> the meantime, so that's not a problem.
> 
> Then you should definitely try cvs2svn/cvs2git [1].  cvsps-based
> conversion tools all have known and unavoidable problems due to the
> limitations of cvsps.
> 

Michael,

Does cvs2git plans to support incremental importing?

 - Samuel
