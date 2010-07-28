From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
	available repositories
Date: Tue, 27 Jul 2010 20:10:45 -0500
Message-ID: <20100728011045.GB2248@dert.cs.uchicago.edu>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu> <20100726232855.GA3157@burratino> <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com> <201007270916.59210.j.sixt@viscovery.net> <20100727174105.GA5578@burratino> <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 28 03:10:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdvAa-0004df-LI
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 03:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab0G1BKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 21:10:47 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:45406 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab0G1BKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 21:10:46 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 05AFF9E9D;
	Tue, 27 Jul 2010 20:10:46 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id C21CD1412; Tue, 27 Jul 2010 20:10:45 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152024>

Greg Brockman wrote:

> So if I'm not mistaken, the only outstanding issue is

I forgot to say: thanks for writing this series.  Although
so far I have been lucky enough not to need to interact with
git-shell much[1], when in the future I need to set up or
interact with a local hosting site the interface this series
creates would be pleasant indeed.

[1] except on the client side through Girocco
http://repo.or.cz/w/girocco.git
