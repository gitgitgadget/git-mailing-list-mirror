From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: Can git pull from a mercurial repository?
Date: Wed, 26 Sep 2012 10:38:30 +0300
Organization: Unix Solutions Ltd. (http://unixsol.org/)
Message-ID: <5062B0F6.1040906@unixsol.org>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se> <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de> <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	'Andreas Ericsson' <ae@op5.se>, git@vger.kernel.org
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 09:38:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGmCi-0003LG-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 09:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab2IZHic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 03:38:32 -0400
Received: from ns.unixsol.org ([193.110.159.2]:38744 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab2IZHic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 03:38:32 -0400
Received: from [10.0.1.78] ([::ffff:10.0.1.78])
  (AUTH: CRAM-MD5 gf, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by ns.unixsol.org with ESMTPSA; Wed, 26 Sep 2012 10:38:30 +0300
  id 0000000000188669.5062B0F6.00007A32
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206397>

Around 09/25/2012 05:15 PM, Max Horn scribbled:
> I think there is a lot of demand for a "git-hg" bridge, a way to seemlessly access a Mercurial repository as if it was a git repository. A converse to hg-git <http://hg-git.github.com/>

I've already mentioned this, but such a tool already exists and it
is working very well (IMHO): http://offbytwo.com/git-hg/

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
