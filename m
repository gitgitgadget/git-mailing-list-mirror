From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git push refspec problem
Date: Wed, 07 Nov 2007 16:26:16 +0100
Message-ID: <4731D918.6040106@hackvalue.de>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com> <Pine.LNX.4.64.0711071510480.4362@racer.site> <20071107152003.GL18057@artemis.corp> <EA230407-45F1-4F7E-8415-A43ECF940856@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: James <jtp@nc.rr.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:26:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmnM-0001d1-Ed
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbXKGP0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbXKGP0D
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:26:03 -0500
Received: from avalon.gnuzifer.de ([85.10.199.84]:42677 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbXKGP0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:26:03 -0500
Received: from 6-142.vpn.rwth-aachen.de ([134.130.246.142]:34434)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1Ipmn0-00073Q-Gl; Wed, 07 Nov 2007 16:25:58 +0100
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
In-Reply-To: <EA230407-45F1-4F7E-8415-A43ECF940856@nc.rr.com>
X-Enigmail-Version: 0.95.2
OpenPGP: id=42F6DE81;
	url=http://pgpkeys.pca.dfn.de/pks/lookup?op=get&search=0x58EEB17842F6DE81
X-SA-Exim-Connect-IP: 134.130.246.142
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63824>

James wrote:
> There has to be *some* way of pulling through git and pushing through
> ssh with a simple "git push".  :-P  I'm doing it manually, after all.  I
> could have sworn I've read how to do its somewhere but have since
> forgotten.

Would two remotes do the trick? One remote only has a fetch entry
while the other one has a push entry.

Regards,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
