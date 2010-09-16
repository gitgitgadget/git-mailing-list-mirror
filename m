From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 15:46:20 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4C921FAC.9000108@atlas-elektronik.com>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Thu Sep 16 15:45:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwEme-0004tq-Qf
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab0IPNpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 09:45:50 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:57397 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840Ab0IPNpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 09:45:49 -0400
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 37AAF138A5
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 15:45:48 +0200 (CEST)
X-AuditID: 0ac86512-00001798000005d0-60-4c921f8b0104
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 16 Sep 2010 15:45:47 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 90F4B2717C;
	Thu, 16 Sep 2010 15:45:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 7CE902717B;
	Thu, 16 Sep 2010 15:45:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <20100916125337.GG5785@bowser.ece.utexas.edu>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156328>

On 9/16/2010 2:53 PM, Kumar Appaiah wrote:
> Hi!
> 
> I observed that, since commit
> 53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
> seem to work the same way as I had expected it to. The documentation
> update doesn't seem to indicate that this was to be expected (or I
> didn't understand it properly). Could someone please confirm that
> tig show <commit> should actually do something similar to git show <commit> | tig ?
> 
> Thanks!

Works as expected for me on Debian Linux 5.0.6 i686:

$ git version
git version 1.7.2.3

$ git describe
tig-0.16-11-gf1fe753

and on Cygwin with the same tig version and "git version 1.7.2.3.msysgit.1"

Your tig version, OS, etc. ?

Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Useless Invention: Leather cutlery.
