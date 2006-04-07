From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Fri, 07 Apr 2006 10:27:14 +0200
Organization: At home
Message-ID: <e157ov$nda$1@sea.gmane.org>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com> <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org> <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org> <7vhd55ls24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Apr 07 10:27:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRmJT-0006iq-BV
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 10:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWDGI1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 04:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWDGI1X
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 04:27:23 -0400
Received: from main.gmane.org ([80.91.229.2]:35275 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932331AbWDGI1W (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 04:27:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FRmJJ-0006hf-Hb
	for git@vger.kernel.org; Fri, 07 Apr 2006 10:27:17 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Apr 2006 10:27:17 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Apr 2006 10:27:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18495>

Junio C Hamano wrote:

>  * pack-*.pack file has the following format:
[...]
>  * pack-*.idx file has the following format:
[...]
Could you please put the information in parent post somewhere in
Documentation, for example Documentation/technical/pack-format.txt
(perhaps together with putting description of packing heuristic from
http://marc.theaimsgroup.com/?l=git&m=114134881923320 by Jon Loeliger in
Documentation/technical/pack-heuristics.txt even if it doesn't conform to
"serious documentation" standards)?

Thanks in advance
-- 
Jakub Narebski
Warsaw, Poland
