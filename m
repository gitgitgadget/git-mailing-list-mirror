From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Re: [TRIVIAL] Documentation: add: <filepattern>... is
 optional
Date: Tue, 11 Aug 2009 17:06:45 +0200
Message-ID: <1250003205.2707.11.camel@localhost.localdomain>
References: <1249995790.1589.2.camel@localhost.localdomain>
	 <20090811145041.GB12956@vidovic>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaswF-0005zk-RF
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbZHKPGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZHKPGu
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:06:50 -0400
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:44825 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbZHKPGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:06:50 -0400
Received: from [212.123.169.34] (helo=[192.168.1.61])
	by smtp-out0.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1Masw6-0005Mz-Mb; Tue, 11 Aug 2009 17:06:50 +0200
In-Reply-To: <20090811145041.GB12956@vidovic>
X-Mailer: Evolution 2.27.5 (2.27.5-3.kb.1.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125570>

On Tue, 2009-08-11 at 16:50 +0200, Nicolas Sebrecht wrote:
> The 11/08/09, Paul Bolle wrote:
> 
> > <filepattern>... is optional (e.g. when the --all or --update
> > options are used) so use square brackets in the synopsis.
> 
> So <filepattern> is needed in all other cases.

Since it is an optional argument in those cases I'd say it is better to
indicate that it is optional in the synopsis too.


Paul Bolle
