From: Drew Northup <drew.northup@maine.edu>
Subject: Oldest Currently Distributed Git {Re: [RFC/PATCH 0/2]
	Documentation: kicking the "reset --hard" habit}
Date: Fri, 05 Nov 2010 10:39:34 -0400
Message-ID: <1288967974.30670.13.camel@drew-northup.unet.maine.edu>
References: <20101029083516.GA26290@burratino>
	 <vpqzktwv3yx.fsf@bauges.imag.fr> <7vd3qr3tm8.fsf@alter.siamese.dyndns.org>
	 <vpqaalujw69.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 05 15:40:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PENTO-0000bh-Lt
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 15:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0KEOkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 10:40:51 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:58436 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0KEOkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 10:40:49 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oA5EdcTt012096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Nov 2010 10:39:43 -0400
In-Reply-To: <vpqaalujw69.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=9
	Fuz1=9 Fuz2=9
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oA5EdcTt012096
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1289572789.31347@gN6YcRmBmwOtpGWBoYRi+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160814>


On Sun, 2010-10-31 at 15:04 +0100, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > What is the oldest version of git that is shipped with _current_ distros,
> > by the way?
> 
> Debian stable has 1.5.6.5. Since there should be a Debian release
> within the next few months, that should be an upper bound on how old a
> package can get in a release (well, unless for RedHat users maybe).
> 

EPEL for RHEL5 is 1.5.5.6 (plus security/bugfix patches).
RHEL5 itself doesn't have git (as if it did it wouldn't be in EPEL).

We await RHEL6--granted it will take a while to upgrade things to that
point after it comes out.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
