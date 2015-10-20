From: Johan Laenen <johan.laenen+cygwin@gmail.com>
Subject: Re: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.
Date: Tue, 20 Oct 2015 14:23:40 +0000 (UTC)
Message-ID: <loom.20151020T155923-458@post.gmane.org>
References: <loom.20151020T131513-529@post.gmane.org> <vpq37x54vav.fsf@grenoble-inp.fr> <cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 16:24:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoXpl-0007AO-QT
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 16:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbbJTOYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 10:24:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:33737 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbbJTOYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 10:24:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZoXpe-00074x-G4
	for git@vger.kernel.org; Tue, 20 Oct 2015 16:24:06 +0200
Received: from 193.191.180.235 ([193.191.180.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 16:24:06 +0200
Received: from johan.laenen+cygwin by 193.191.180.235 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 16:24:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.191.180.235 (Mozilla/5.0 (Windows NT 6.1; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279914>

Enrique Tobis <Enrique.Tobis <at> twosigma.com> writes:

> 
> Hey!
> 
> I'm really sorry to hear that.
> 
> That change should enable more forms of authentication with your proxy,
but it does cause libcurl to choose
> the one it finds most secure, according to the docs
> (http://curl.haxx.se/libcurl/c/CURLOPT_HTTPAUTH.html) What kinds of
authentication does your
> proxy use?
> 
> Thanks,
> Enrique
> 

Hi,

Thanks for looking into this.

I'm behind a NTLM proxy :/

Greetings,

Johan
